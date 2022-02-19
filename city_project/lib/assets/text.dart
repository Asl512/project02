// ignore_for_file: prefer_const_declarations
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const String textLoading = 'Подождите пожалуйста идет загрузка...';
const String textErrorNet = 'Упс. Нет соединения с интернетом.';
const String textRepeat = 'Повторить';

///ПРОФИЛЬ
const String textNotAutorization = 'Авторизуйтесь что бы пользоваться всеми функциями Наполеона.';
const String textAutorization = 'Авторизоваться';
///Авторизация
const String textWelcome = 'Войти';
const String textEmail = 'Почта:';
const String textPassword = 'Пароль';
const String textHelp = 'Напомнить';
const String textRemember = 'Запомнить';
const String textTerms = 'При входе, вы принимаете условия пользования сервисом. ';
const String textMore = 'Подробнее.';

///РЕГИСТРАЦИЯ
const String textRegistration = 'Регистрация';
const String textNameSurname = 'Имя и Фамилия';

///СТРАНИЦА ПОИСКА
const String textLabelSerch = 'Введите название города';

///МЕНЮ
const String textExcursion = 'Экскурсии';
const String textMyTickets = 'Мои билеты';
const String textActivity = 'Активность';
const String textProfil = 'Профиль';

///СТРАНИЦА ГОРОДА
const String textSorting = 'Сортировка';
const String textShow = 'Показать';
String textPlacesLeft(String places){return 'Осталось: ' + places +' мест';}
String textPerPerson(String price){return price +' руб. за человека';}
List<String> typesName= ['Экскурсии','Афиша','Новости'];
String textDontMero = 'В данном городе пока что нет активных мероприятий';

///ВОССТАНОВЛЕНИЕ ПАРОЛЯ
const String textRecoveryPassword = 'ВОССТАНОВЛЕНИЕ ПАРОЛЯ';
const String textInstructionRecoveryOne = 'Введите почту, с которой Вы регестрировались в приложение и нажмите “ДАЛЕЕ”';
const String textInstructionRecoveryTwo = 'Мы отправили Вам код на указанную почту, а Вам остаётся только ввести его';
const String textNext = 'ДАЛЕЕ';
const String textNewPassword = 'Новый пароль';
const String textRepeatPassword = 'Повторите пароль';

///УСЛОВИЯ СЕРВИСА
const String textConditions = 'Условия использования сайта регламентируют взаимодействие путешественников, гидов и Трипстера. Все юридические подробности изложены в документах: политика конфиденциальности, договор между гидом и Трипстером (принимаются при регистрации, а фактически начинает работать после публикации экскурсии) и договоры оказания экскурсионных услуг между гидом и путешественником (принимаются гидом и путешественником при внесении предоплаты за экскурсию).';

///СТРАНИЦА ЭКСКУРСИИ
const String textPay = 'Оплатить';
const String textDontReview = 'Отзывов на данное мероптиятие, пока что нет';
const String textDontImages = 'Фотографий данного мероптиятия, пока что нет';
const String textCounPeaple = 'Количество человек:';
const String textProceedPay = 'Перейти к оплате';

///ЛИЧНОЕ ПРОСТРАНСТВО
const String textDontTickets = 'Вы еще не преобрели билеты на мероприятия';
const String textHi = 'Привет, ';
const String textSettings = 'Настройки';
const String textExit= 'Выход';
const String textAddExcursion = 'Добавить мероприятие';
const String textFavorite = 'Избранное';
const String textMyExcursion = 'Мои мероприятия';
const String textEditName = 'Поменять имя';
const String textEditEmail = 'Поменять почту';
const String textEditPhone = 'Поменять телефон';
const String textEditPassword = 'Поменять пароль';
const String textDontUserMero = 'У данного пользователя пока что, нет мороприятий';
const String textDontMyMero = 'У вас пока что нет мероприятий';

///ДОБАВИТЬ МЕРОПРИЯТИЕ
const String textInputName = 'Введите название';
const String textSelectName = 'Название мероприятия';
const String textSelectType = 'Тип мероприятия';
const String textInputType = 'Выбирите тип мероприятия';
const String textSelectCity = 'Город';
const String textInputCity = 'Выбирите город';
const String textSelectStart = 'Место встречи';
const String textInputStart = 'Введите точку отправления';
const String textConfirm = 'Подтвердить';
const String textSelectCountPeaple = 'Количество человек';
const String textInputCountPeaple = 'На сколько человек расчитано мероприятие';
const String textSelectLang = 'Языки мероприятия';
const String textInputLang = 'Выберите язык';
const String textSelectDate = 'Дата мероприятия';
const String textInputDate = 'Выберите дату мероприятия';
const String textSelectTimeStart = 'Время начала мероприятия';
const String textInputTime = 'Выберите время';
const String textSelectTimeEnd = 'Время окончания мероприятия';
const String textInputPay = 'Введите стоимость за одного человека';
const String textSelectPay= 'Стоимость';
const String textSelectMove = 'Способ передвижения';
const String textInputMove = 'Выберите способ передвижения';
const String textDescription = 'Описание';
const String textDescriptionPlac = 'В чем заключается ваш подход? Что именно вы хотите рассказать на экскурсии? Какие места вы выбрали и почему?';