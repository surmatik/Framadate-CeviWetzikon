<?php
/**
 * This software is governed by the CeCILL-B license. If a copy of this license
 * is not distributed with this file, you can obtain one at
 * http://www.cecill.info/licences/Licence_CeCILL-B_V1-en.txt
 *
 * Authors of STUdS (initial project): Guilhem BORGHESI (borghesi@unistra.fr) and Raphaël DROZ
 * Authors of Framadate/OpenSondage: Framasoft (https://github.com/framasoft https://framagit.org/framasoft/framadate/)
 *
 * =============================
 *
 * Ce logiciel est régi par la licence CeCILL-B. Si une copie de cette licence
 * ne se trouve pas avec ce fichier vous pouvez l'obtenir sur
 * http://www.cecill.info/licences/Licence_CeCILL-B_V1-fr.txt
 *
 * Auteurs de STUdS (projet initial) : Guilhem BORGHESI (borghesi@unistra.fr) et Raphaël DROZ
 * Auteurs de Framadate/OpenSondage : Framasoft (https://github.com/framasoft https://framagit.org/framasoft/framadate/)
 */
use Framadate\Choice;
use Framadate\Services\InputService;
use Framadate\Services\LogService;
use Framadate\Services\MailService;
use Framadate\Services\PollService;
use Framadate\Services\PurgeService;
use Framadate\Services\SessionService;
use Framadate\Utils;

include_once __DIR__ . '/app/inc/init.php';

/* Service */
/*---------*/
$logService = new LogService();
$pollService = new PollService($logService);
$mailService = new MailService($config['use_smtp'], $config['smtp_options']);
$purgeService = new PurgeService($logService);
$inputService = new InputService();
$sessionService = new SessionService();

if (is_readable('bandeaux_local.php')) {
    include_once('bandeaux_local.php');
}

$form = unserialize($_SESSION['form']);

// The poll format is DATE if we are in this file
if (!isset($form->format)) {
    $form->format = 'D';
}
// If we come from another format, we need to clear choices
if (isset($form->format) && $form->format !== 'D') {
    $form->format = 'D';
    $form->clearChoices();
}

if (!isset($form->title, $form->admin_name) || ($config['use_smtp'] && !isset($form->admin_mail))) {
    $step = 1;
} else if (!empty($_POST['confirmation'])) {
    $step = 4;
} else if (empty($_POST['choixheures']) || isset($form->totalchoixjour)) {
    $step = 2;
} else {
    $step = 3;
}

switch ($step) {
    case 1:
        // Step 1/4 : error if $_SESSION from info_sondage are not valid
        $smarty->assign('title', __('Error', 'Error!'));
        $smarty->assign('error', __('Error', 'You haven\'t filled the first section of the poll creation.'));
        $smarty->display('error.tpl');
        exit;

    case 2:
        // Step 2/4 : Select dates of the poll

        // Prefill form->choices
        foreach ($form->getChoices() as $c) {
            /** @var Choice $c */
            $count = 3 - count($c->getSlots());
            for ($i = 0; $i < $count; $i++) {
                $c->addSlot('');
            }
        }

        $count = 3 - count($form->getChoices());
        for ($i = 0; $i < $count; $i++) {
            $c = new Choice('');
            $c->addSlot('');
            $c->addSlot('');
            $c->addSlot('');
            $form->addChoice($c);
        }

        $_SESSION['form'] = serialize($form);

        // Display step 2
        $smarty->assign('title', __('Step 2 date', 'Poll dates (2 on 3)'));
        $smarty->assign('choices', $form->getChoices());
        $smarty->assign('error', null);

        $smarty->display('create_date_poll_step_2.tpl');
        exit;

    case 3:
        // Step 3/4 : Confirm poll creation

        // Handle Step2 submission
        if (!empty($_POST['days'])) {
            // Remove empty dates
            $_POST['days'] = array_filter($_POST['days'], static function ($d) {
                return !empty($d);
            });

            // Check if there are at most MAX_SLOTS_PER_POLL slots
            if (count($_POST['days']) > MAX_SLOTS_PER_POLL) {
                // Display step 2
                $smarty->assign('title', __('Step 2 date', 'Poll dates (2 on 3)'));
                $smarty->assign('choices', $form->getChoices());
                $smarty->assign('error', __f('Error', 'You can\'t select more than %d dates', MAX_SLOTS_PER_POLL));

                $smarty->display('create_date_poll_step_2.tpl');
                exit;
            }

            // Clear previous choices
            $form->clearChoices();

            // Reorder moments to deal with suppressed dates
            $moments = [];
            $i = 0;
            while(count($moments) < count($_POST['days'])) {
                if (!empty($_POST['horaires' . $i])) {
                    $moments[] = $_POST['horaires' . $i];
                }
                $i++;
            }

            for ($i = 0, $iMax = count($_POST['days']); $i < $iMax; $i++) {
                $day = $_POST['days'][$i];

                if (!empty($day)) {
                    // Add choice to Form data
                    $date = DateTime::createFromFormat(__('Date', 'datetime_parseformat'), $_POST['days'][$i])->setTime(0, 0, 0);
                    $time = $date->getTimestamp();
                    $choice = new Choice($time);
                    $form->addChoice($choice);

                    $schedules = $inputService->filterArray($moments[$i], FILTER_DEFAULT);
                    for ($j = 0, $jMax = count($schedules); $j < $jMax; $j++) {
                        if (!empty($schedules[$j])) {
                            $choice->addSlot(strip_tags($schedules[$j]));
                        }
                    }
                }
            }
            $form->sortChoices();
        }

        // Display step 3
        $summary = '<ul>';
        $choices = $form->getChoices();
        foreach ($choices as $choice) {
            $summary .= '<li>' . formatDate($date_format['txt_full'], $choice->getName());
            $first = true;
            foreach ($choice->getSlots() as $slots) {
                $summary .= $first ? ': ' : ', ';
                $summary .= $slots;
                $first = false;
            }
            $summary .= '</li>';
        }
        $summary .= '</ul>';

        $end_date_str = utf8_encode(formatDate($date_format['txt_date'], $pollService->maxExpiryDate()->getTimestamp())); // textual date

        $_SESSION['form'] = serialize($form);

        $smarty->assign('title', __('Step 3', 'Removal date and confirmation (3 on 3)'));
        $smarty->assign('summary', $summary);
        $smarty->assign('end_date_str', $end_date_str);
        $smarty->assign('default_poll_duration', $config['default_poll_duration']);
        $smarty->assign('use_smtp', $config['use_smtp']);

        $smarty->display('create_classic_poll_step3.tpl');
        exit;

    case 4:
        // Step 4 : Data prepare before insert in DB

        // Define expiration date
        $expiration_date = $inputService->parseDate($_POST['enddate']);
        $form->end_date = $inputService->validateDate($expiration_date, $pollService->minExpiryDate(), $pollService->maxExpiryDate())->getTimestamp();

        // Insert poll in database
        $ids = $pollService->createPoll($form);
        $poll_id = $ids[0];
        $admin_poll_id = $ids[1];

        // Send confirmation by mail if enabled
        if ($config['use_smtp'] === true) {
            $message = '<div style="text-align: center; background-color: #e1e1e1; padding: 20px;"><img src="https://i.postimg.cc/KjVgCXz4/Cevi-Wetikon-horizontal-schwarz.png" height="50" alt="Cevi Wetzikon Pool Tool"></div>';
            $message .= '<br><br>';
            $message .= 'Liebe/r ' . Utils::htmlMailEscape($form->admin_name);
            $message .= '<br/><br/>';
            $message .= 'Deine Umfrage "' . Utils::htmlMailEscape($form->title) . '" wurde soeben erstellt.';
            $message .= '<br><br><b>👉 Link zur Umfrage</b><br>Mit dem folgenden Link kannst du andere einladen, an deiner Umfrage teilzunehmen: <a href="' . Utils::getUrlSondage($poll_id) . '" style="color: black; text-decoration: underline;">' . Utils::getUrlSondage($poll_id) . '</a>';
            $message .= '<br><br><b>👉 Admin Link</b><br>Verwende den folgenden Link, um alle Details deiner Umfrage zu bearbeiten: <a href="' . Utils::getUrlSondage($admin_poll_id, true) . '" style="color: black; text-decoration: underline;">' . Utils::getUrlSondage($admin_poll_id, true) . '</a>';
        
            if ($mailService->isValidEmail($form->admin_mail)) {
                $subject = '🌳 Deine Cevi Umfrage ' . Utils::htmlEscape($form->title);
                $subject = str_replace("&period;", ".", $subject);
                $subject = mb_encode_mimeheader($subject, "UTF-8", "B");
                $mailService->send($form->admin_mail, $subject, $message);
            }
        }

        // Clean Form data in $_SESSION
        unset($_SESSION['form']);

        // Delete old polls
        $purgeService->purgeOldPolls();

        // creation message
        $sessionService->set("Framadate", "messagePollCreated", TRUE);

        // Redirect to poll administration
        header('Location:' . Utils::getUrlSondage($admin_poll_id, true));
        exit;
}
