-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Хост: 127.0.0.1
-- Время создания: Дек 05 2022 г., 17:01
-- Версия сервера: 10.4.24-MariaDB
-- Версия PHP: 8.1.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- База данных: `tp`
--

-- --------------------------------------------------------

--
-- Структура таблицы `marriage`
--

CREATE TABLE `marriage` (
  `id` int(11) NOT NULL,
  `id_husband` int(11) NOT NULL,
  `id_wife` int(11) NOT NULL,
  `date_marriage` date NOT NULL,
  `date_divorce` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `sex`
--

CREATE TABLE `sex` (
  `id` int(11) NOT NULL,
  `sex` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `sex`
--

INSERT INTO `sex` (`id`, `sex`) VALUES
(1, 'мужской'),
(2, 'женский');

-- --------------------------------------------------------

--
-- Структура таблицы `trees`
--

CREATE TABLE `trees` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `tree_leafs`
--

CREATE TABLE `tree_leafs` (
  `id` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `DOB` date NOT NULL,
  `DOD` date DEFAULT NULL,
  `id_last_editor` int(11) NOT NULL,
  `id_father` int(11) NOT NULL,
  `id_mother` int(11) NOT NULL,
  `id_previous` int(11) NOT NULL,
  `id_tree` int(11) NOT NULL,
  `id_sex` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `id_leafs` int(11) NOT NULL,
  `name` varchar(50) NOT NULL,
  `registration_date` date NOT NULL,
  `last_visit` date NOT NULL,
  `login` varchar(100) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `id_type_user` int(11) NOT NULL,
  `id_sex` int(11) NOT NULL,
  `DOB` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Структура таблицы `user_types`
--

CREATE TABLE `user_types` (
  `id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Дамп данных таблицы `user_types`
--

INSERT INTO `user_types` (`id`, `type`) VALUES
(1, 'Пользователь с правами редактирования'),
(2, 'Пользователь');

--
-- Индексы сохранённых таблиц
--

--
-- Индексы таблицы `marriage`
--
ALTER TABLE `marriage`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `sex`
--
ALTER TABLE `sex`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `trees`
--
ALTER TABLE `trees`
  ADD PRIMARY KEY (`id`);

--
-- Индексы таблицы `tree_leafs`
--
ALTER TABLE `tree_leafs`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_father` (`id_father`),
  ADD KEY `id_mother` (`id_mother`),
  ADD KEY `id_previous` (`id_previous`),
  ADD KEY `id_tree` (`id_tree`),
  ADD KEY `id_sex` (`id_sex`),
  ADD KEY `id_last_editor` (`id_last_editor`);

--
-- Индексы таблицы `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_sex` (`id_sex`),
  ADD KEY `id_leafs` (`id_leafs`),
  ADD KEY `id_type_user` (`id_type_user`);

--
-- Индексы таблицы `user_types`
--
ALTER TABLE `user_types`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT для сохранённых таблиц
--

--
-- AUTO_INCREMENT для таблицы `marriage`
--
ALTER TABLE `marriage`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `sex`
--
ALTER TABLE `sex`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT для таблицы `trees`
--
ALTER TABLE `trees`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `tree_leafs`
--
ALTER TABLE `tree_leafs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT для таблицы `user_types`
--
ALTER TABLE `user_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Ограничения внешнего ключа сохраненных таблиц
--

--
-- Ограничения внешнего ключа таблицы `tree_leafs`
--
ALTER TABLE `tree_leafs`
  ADD CONSTRAINT `tree_leafs_ibfk_1` FOREIGN KEY (`id_father`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tree_leafs_ibfk_2` FOREIGN KEY (`id_mother`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tree_leafs_ibfk_3` FOREIGN KEY (`id_previous`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tree_leafs_ibfk_4` FOREIGN KEY (`id_tree`) REFERENCES `trees` (`id`),
  ADD CONSTRAINT `tree_leafs_ibfk_5` FOREIGN KEY (`id_sex`) REFERENCES `sex` (`id`),
  ADD CONSTRAINT `tree_leafs_ibfk_6` FOREIGN KEY (`id_last_editor`) REFERENCES `users` (`id`);

--
-- Ограничения внешнего ключа таблицы `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `users_ibfk_1` FOREIGN KEY (`id_sex`) REFERENCES `sex` (`id`),
  ADD CONSTRAINT `users_ibfk_2` FOREIGN KEY (`id_leafs`) REFERENCES `tree_leafs` (`id`),
  ADD CONSTRAINT `users_ibfk_3` FOREIGN KEY (`id_type_user`) REFERENCES `user_types` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
