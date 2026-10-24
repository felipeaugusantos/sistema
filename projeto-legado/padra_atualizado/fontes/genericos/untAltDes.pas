unit untAltDes;
{************************************************************}
{* Unit Criada com a Finalidade de inserir na tabela ALTDES *}
{* o registro das alteraçoes dos campos de descrição,       *}
{* referencia e codigo da unidade. Essa informação é neces  *}
{* sária no sistema fiscal, para saber qual o período o     *}
{* item manteve com determinados valores.                   *}
{*                                                          *}
{* DATA : 27/01/2014                                        *}
{* AUTOR: GUILHERME BORGES DE FREITAS                       *}
{*                                                          *}
{************************************************************}

interface

uses Uni;

type
  TAltDes = Class
  public
    class procedure pSalvaLog(strCodIte, strCodOpe: String; strDesAnt : String = ''; strRefAnt : String = ''; strUniAnt : String = '';
          strDesSim: String = ''; strAplica: String = '');
    class procedure pSalvaLogCompara(strCodIte, strCodOpe, strDesNew , strRefNew, strUniNew : String);
  End;

implementation

uses SysUtils, Variants, untFuncoesSimples, Forms;

{ TAltDes }

class procedure TAltDes.pSalvaLog(strCodIte, strCodOpe, strDesAnt,
  strRefAnt, strUniAnt, strDesSim, strAplica: String);
  var
    qryAux    : TUniQuery;
    dtaDtaIni : TDateTime;

begin
  Try
    qryAux := fCriaQuery(Application);
    With qryAux, Sql Do
    Begin
      // Inicializa a Data Inicial com a Data da Ultima Alteração.
      Close;
      Clear;
      Add(' SELECT MAX(LOG_DTAFIM) DF  ');
      Add(' FROM ALTDES                ');
      Add(' WHERE LOG_CODITE = :CODITE ');

      ParamByName('CODITE').AsString := strCodIte;

      Open;

      dtaDtaIni := FieldByName('DF').AsDateTime;

      // Caso não tenha passado os Valores Anteriores pega do cadastro.
      if fEmptyStr(strDesAnt) or
         fEmptyStr(strRefAnt) or
         fEmptyStr(strUniAnt) or
         (dtaDtaIni = 0 )Then
      Begin
         Close;
         Clear;
         Add(' SELECT SQL_NO_CACHE   ');
         Add('        I.ITE_DESITE,  ');
         Add('        I.ITE_REFERE,  ');
         Add('        I.ITE_CODUNI,  ');
         Add('        I.ITE_DTACAD,  ');
         Add('        G.ITE_DTABAL,   ');
         Add('        I.ITE_DESSIM,   ');
         Add('        I.ITE_APLICA   ');
         Add(' FROM CADITE I         ');
         Add(' LEFT JOIN ITEGER G ON (G.ITE_CODITE = I.ITE_CODITE AND G.ITE_CODEMP = :CODEMP) ');
         Add(' WHERE I.ITE_CODITE = :CODITE ');

         ParamByName('CODITE').AsString := strCodIte;
         ParamByName('CODEMP').AsString := VS_strCodEmp;

         Open;

         if fEmptyStr(strDesAnt) Then
           strDesAnt := FieldByName('ITE_DESITE').AsString;

         if fEmptyStr(strRefAnt) Then
           strRefAnt := FieldByName('ITE_REFERE').AsString;

         if fEmptyStr(strUniAnt) Then
           strUniAnt := FieldByName('ITE_CODUNI').AsString;

         If FieldByName('ITE_DTACAD').AsDateTime <> 0 Then
         Begin
           dtaDtaIni := FieldByName('ITE_DTACAD').AsDateTime;
         End Else
         Begin
           If FieldByName('ITE_DTABAL').AsDateTime <> 0 Then
             dtaDtaIni := FieldByName('ITE_DTABAL').AsDateTime
           Else
             dtaDtaIni := VS_Date;
         End;

         if fEmptyStr(strDesSim) Then
           strDesSim := FieldByName('ITE_DESSIM').AsString;

         if fEmptyStr(strAplica) Then
           strAplica := FieldByName('ITE_APLICA').AsString;

      End;

      Close;
      Clear;
      Add(' INSERT INTO ALTDES ( ');
      Add('         AUTOINCREM,  ');
      Add('         LOG_CODOPE,  ');
      Add('         LOG_CODITE,  ');
      Add('         LOG_HRAALT,  ');
      Add('         LOG_DTAINI,  ');
      Add('         LOG_DTAFIM,  ');
      Add('         LOG_DESANT,  ');
      Add('         LOG_REFANT,  ');
      Add('         LOG_APLANT,  ');
      Add('         LOG_SIMANT,  ');
      Add('         LOG_UNIANT)  ');
      Add(' VALUES (             ');
      Add('         :AUTOIN,     ');
      Add('         :CODOPE,     ');
      Add('         :CODITE,     ');
      Add('         :HRAALT,     ');
      Add('         :DTAINI,     ');
      Add('         :DTAFIM,     ');
      Add('         :DESANT,     ');
      Add('         :REFANT,     ');
      Add('         :APLICA,     ');
      Add('         :DESSIM,     ');
      Add('         :UNIANT)     ');

      ParamByName('AUTOIN').AsString   := fRetAutoIncrem('ALTDES', VS_strCodEmp);
      ParamByName('CODOPE').AsString   := strCodOpe;
      ParamByName('CODITE').AsString   := strCodIte;
      ParamByName('HRAALT').AsDateTime := fNow();
      ParamByName('DTAINI').AsDateTime := dtaDtaIni;
      ParamByName('DTAFIM').AsDateTime := VS_Date;
      ParamByName('DESSIM').AsString := strDesSim;
      ParamByName('APLICA').AsString := strAplica;

      If Not fEmptyStr(strDesAnt) Then
        ParamByName('DESANT').AsString := strDesAnt
      Else ParamByName('DESANT').Value := Null;

      If Not fEmptyStr(strRefAnt) Then
        ParamByName('REFANT').AsString := strRefAnt
      Else ParamByName('REFANT').Value := Null;

      If Not fEmptyStr(strUniAnt) Then
        ParamByName('UNIANT').AsString := strUniAnt
      Else ParamByName('UNIANT').Value := Null;

      ExecSQL;

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

class procedure TAltDes.pSalvaLogCompara(strCodIte, strCodOpe, strDesNew, strRefNew, strUniNew: String);
  var
    qryAux    : TUniQuery;
    strDesAtu,
    strRefAtu,
    strUniAtu : String;

begin
  Try
    qryAux := fCriaQuery(Application);
    With qryAux, Sql Do
    Begin
       Close;
       Clear;
       Add(' SELECT SQL_NO_CACHE ');
       Add('        ITE_DESITE,  ');
       Add('        ITE_REFERE,  ');
       Add('        ITE_CODUNI   ');
       Add(' FROM CADITE         ');
       Add(' WHERE ITE_CODITE = :CODITE ');

       ParamByName('CODITE').AsString := strCodIte;

       Open;

       strDesAtu := FieldByName('ITE_DESITE').AsString;
       strRefAtu := FieldByName('ITE_REFERE').AsString;
       strUniAtu := FieldByName('ITE_CODUNI').AsString;

       if (strDesAtu <> strDesNew) or
          (strRefAtu <> strRefNew) or
          (strUniAtu <> strUniNew) Then
          pSalvaLog(strCodIte, strCodOpe, strDesAtu, strRefAtu, strUniAtu);
    end;

  Finally
    FreeAndNil(qryAux);
  End;


end;

end.
