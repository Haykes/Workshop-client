<?php

namespace App\Controller\Admin;

use App\Entity\Field;
use App\Entity\FieldOption;
use App\Entity\Report;
use App\Entity\ReportEntry;
use App\Entity\Role;
use App\Entity\RoleUser;
use App\Entity\User;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractDashboardController;
use EasyCorp\Bundle\EasyAdminBundle\Router\AdminUrlGenerator;
use EasyCorp\Bundle\EasyAdminBundle\Config\Dashboard;
use EasyCorp\Bundle\EasyAdminBundle\Config\MenuItem;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AdminDashboardController extends AbstractDashboardController
{
    #[Route('/admin', name: 'admin')]
    public function index(): Response
    {
        if (!$this->isGranted('ROLE_ADMIN')) {
            return $this->redirectToRoute('app_login');
        }

        return $this->render('admin/dashboard.html.twig', [
        ]);
    }

    public function configureDashboard(): Dashboard
    {
        return Dashboard::new()
            ->setTitle('Workshop Client Admin');
    }

    public function configureMenuItems(): iterable
    {
        yield MenuItem::linkToDashboard('Tableau de bord', 'fa fa-home');

        yield MenuItem::section('Données principales');
        yield MenuItem::linkToCrud('Utilisateurs', 'fa fa-users', User::class);
        yield MenuItem::linkToCrud('Rôles', 'fa fa-shield-alt', Role::class);
        yield MenuItem::linkToCrud('RoleUser', 'fa fa-user-tag', RoleUser::class);

        yield MenuItem::section('Bulletins');
        yield MenuItem::linkToCrud('Bulletins (Report)', 'fa fa-file-alt', Report::class);
        yield MenuItem::linkToCrud('Entrées (ReportEntry)', 'fa fa-file-signature', ReportEntry::class);

        yield MenuItem::section('Champs dynamiques');
        yield MenuItem::linkToCrud('Champs (Field)', 'fa fa-list', Field::class);
        yield MenuItem::linkToCrud('Options (FieldOption)', 'fa fa-list-alt', FieldOption::class);
    }
}
