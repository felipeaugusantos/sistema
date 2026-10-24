unit untPreAlt;

interface

uses
{$IFDEF LINUX}
  {$I '..\..\..\core\services.core.uses.inc'},
{$ELSE}
  Uni,
{$ENDIF}
  SysUtils, Classes, DB, StrUtils;

function fGravaPreAlt(strCodIte: String;
                      fltCusAnt,
                      fltCusAtu,
                      fltVe1Ant,
                      fltVe1Atu,
                      fltMa1Ant,
                      fltMa1Atu,
                      fltVe2Ant,
                      fltVe2Atu,
                      fltMa2Ant,
                      fltMa2Atu,
                      fltVe3Ant,
                      fltVe3Atu,
                      fltMa3Ant,
                      fltMa3Atu,
                      fltVe4Ant,
                      fltVe4Atu,
                      fltMa4Ant,
                      fltMa4Atu,
                      fltVe5Ant,
                      fltVe5Atu,
                      fltMa5Ant,
                      fltMa5Atu,
                      fltVe6Ant,
                      fltVe6Atu,
                      fltMa6Ant,
                      fltMa6Atu,
                      fltVe7Ant,
                      fltVe7Atu,
                      fltMa7Ant,
                      fltMa7Atu,
                      fltComAnt,
                      fltComAtu: Double;
                      strNomFrm: String;
                      DataSet : TDataSet = nil;
                      strCodEmp: String = '';
                      strCodOpe: String = '';
                      strAutoincrem: String = ''): Boolean;

function fGravaPreAltCat(qryPreNew: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF}): Boolean;

implementation

{$IFDEF LINUX}
{$ELSE}
uses
  untFuncoesSimples;
{$ENDIF}


{*****************************************}
{* FAZ A GRAVAÇÃO DA TABELA DE PREÇOS    *}
{* ALTERADOS                             *}
{**************************************MV*}
function fGravaPreAlt(strCodIte: String;
                      fltCusAnt,
                      fltCusAtu,
                      fltVe1Ant,
                      fltVe1Atu,
                      fltMa1Ant,
                      fltMa1Atu,
                      fltVe2Ant,
                      fltVe2Atu,
                      fltMa2Ant,
                      fltMa2Atu,
                      fltVe3Ant,
                      fltVe3Atu,
                      fltMa3Ant,
                      fltMa3Atu,
                      fltVe4Ant,
                      fltVe4Atu,
                      fltMa4Ant,
                      fltMa4Atu,
                      fltVe5Ant,
                      fltVe5Atu,
                      fltMa5Ant,
                      fltMa5Atu,
                      fltVe6Ant,
                      fltVe6Atu,
                      fltMa6Ant,
                      fltMa6Atu,
                      fltVe7Ant,
                      fltVe7Atu,
                      fltMa7Ant,
                      fltMa7Atu,
                      fltComAnt,
                      fltComAtu: Double;
                      strNomFrm: String;
                      DataSet : TDataSet = nil;
                      strCodEmp: String = '';
                      strCodOpe: String = '';
                      strAutoincrem: String = ''): Boolean;

  var
    qryPreAlt: TDataSet;
    qryExec : {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
    strEmpresas: String;
begin
  strCodEmp := IIf(strCodEmp <> '', strCodEmp, VS_strCodEmp);

  Result := True;

  if DataSet = nil then
  begin
   {$IFDEF LINUX}
    qryPreAlt := TDataSet(fCriarQuery('SELECT * FROM PREALT WHERE FALSE').GetObject);
   {$ELSE }
    qryPreAlt := fCriarQuery('SELECT * FROM PREALT WHERE FALSE');
   {$ENDIF}
  end
  else
    qryPreAlt := DataSet;

  With qryPreAlt Do
  Begin
    Try

      If (fFormataFloat(fltMa1Atu, 2) <> fFormataFloat(fltMa1Ant, 2)) Or
         (fFormataFloat(fltMa2Atu, 2) <> fFormataFloat(fltMa2Ant, 2)) Or
         (fFormataFloat(fltMa3Atu, 2) <> fFormataFloat(fltMa3Ant, 2)) Or
         (fFormataFloat(fltMa4Atu, 2) <> fFormataFloat(fltMa4Ant, 2)) Or
         (fFormataFloat(fltMa5Atu, 2) <> fFormataFloat(fltMa5Ant, 2)) Or
         (fFormataFloat(fltMa6Atu, 2) <> fFormataFloat(fltMa6Ant, 2)) Or
         (fFormataFloat(fltMa7Atu, 2) <> fFormataFloat(fltMa7Ant, 2)) Or
         (fFormataFloat(fltVe1Atu, 2) <> fFormataFloat(fltVe1Ant, 2)) Or
         (fFormataFloat(fltVe2Atu, 2) <> fFormataFloat(fltVe2Ant, 2)) Or
         (fFormataFloat(fltVe3Atu, 2) <> fFormataFloat(fltVe3Ant, 2)) Or
         (fFormataFloat(fltVe4Atu, 2) <> fFormataFloat(fltVe4Ant, 2)) Or
         (fFormataFloat(fltVe5Atu, 2) <> fFormataFloat(fltVe5Ant, 2)) Or
         (fFormataFloat(fltVe6Atu, 2) <> fFormataFloat(fltVe6Ant, 2)) Or
         (fFormataFloat(fltVe7Atu, 2) <> fFormataFloat(fltVe7Ant, 2)) Or
         (fFormataFloat(fltCusAtu, 2) <> fFormataFloat(fltCusant, 2)) Then
      Begin

        If (DataSet = nil) and  (Not qryPreAlt.Active) Then
          qryPreAlt.Open;

        Insert;
        FieldByName('ALT_CODEMP').AsString  := IfThen(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);
        FieldByName('ALT_CODITE').AsString  := strCodIte;
        FieldByName('ALT_CODOPE').AsString  := IfThen(fEmptyStr(strCodOpe), strLoginUsuarioLogado, strCodOpe);
        FieldByName('ALT_CODOEF').AsString  := strLoginUsuarioLogado;
        FieldByName('ALT_CUSANT').AsFloat   := fltCusAnt;
        FieldByName('ALT_CUSATU').AsFloat   := fltCusAtu;

        FieldByName('ALT_MA1ANT').AsFloat   := fltMa1Ant;
        FieldByName('ALT_MA1ATU').AsFloat   := fltMa1Atu;
        FieldByName('ALT_VE1ANT').AsFloat   := fltVe1Ant;
        FieldByName('ALT_VE1ATU').AsFloat   := fltVe1Atu;

        FieldByName('ALT_MA2ANT').AsFloat   := fltMa2Ant;
        FieldByName('ALT_MA2ATU').AsFloat   := fltMa2Atu;
        FieldByName('ALT_VE2ANT').AsFloat   := fltVe2Ant;
        FieldByName('ALT_VE2ATU').AsFloat   := fltVe2Atu;

        FieldByName('ALT_MA3ANT').AsFloat   := fltMa3Ant;
        FieldByName('ALT_MA3ATU').AsFloat   := fltMa3Atu;
        FieldByName('ALT_VE3ANT').AsFloat   := fltVe3Ant;
        FieldByName('ALT_VE3ATU').AsFloat   := fltVe3Atu;

        FieldByName('ALT_MA4ANT').AsFloat   := fltMa4Ant;
        FieldByName('ALT_MA4ATU').AsFloat   := fltMa4Atu;
        FieldByName('ALT_VE4ANT').AsFloat   := fltVe4Ant;
        FieldByName('ALT_VE4ATU').AsFloat   := fltVe4Atu;

        FieldByName('ALT_MA5ANT').AsFloat   := fltMa5Ant;
        FieldByName('ALT_MA5ATU').AsFloat   := fltMa5Atu;
        FieldByName('ALT_VE5ANT').AsFloat   := fltVe5Ant;
        FieldByName('ALT_VE5ATU').AsFloat   := fltVe5Atu;

        FieldByName('ALT_MA6ANT').AsFloat   := fltMa6Ant;
        FieldByName('ALT_MA6ATU').AsFloat   := fltMa6Atu;
        FieldByName('ALT_VE6ANT').AsFloat   := fltVe6Ant;
        FieldByName('ALT_VE6ATU').AsFloat   := fltVe6Atu;

        FieldByName('ALT_MA7ANT').AsFloat   := fltMa7Ant;
        FieldByName('ALT_MA7ATU').AsFloat   := fltMa7Atu;
        FieldByName('ALT_VE7ANT').AsFloat   := fltVe7Ant;
        FieldByName('ALT_VE7ATU').AsFloat   := fltVe7Atu;

        FieldByName('ALT_COMANT').AsFloat   := fltComAnt;
        FieldByName('ALT_COMATU').AsFloat   := fltComAtu;

        FieldByName('ALT_DTAALT').AsFloat   := VS_Date;
        FieldByName('ALT_HORALT').AsFloat   := fTime();
        FieldByName('ALT_NOMFRM').AsString  := strNomFrm;

        If strAutoincrem.IsEmpty Then
          strAutoincrem := fRetAutoIncrem('PREALT', FieldByName('ALT_CODEMP').AsString, -1, True);

        FieldByName('AUTOINCREM').AsString  := strAutoincrem;

        Post;

        If ((fFormataFloat(fltMa1Atu, 2) <> fFormataFloat(fltMa1Ant, 2)) And (VS_strTabPrc[1] = 'S')) Or
           ((fFormataFloat(fltMa2Atu, 2) <> fFormataFloat(fltMa2Ant, 2)) And (VS_strTabPrc[2] = 'S')) Or
           ((fFormataFloat(fltMa3Atu, 2) <> fFormataFloat(fltMa3Ant, 2)) And (VS_strTabPrc[3] = 'S')) Or
           ((fFormataFloat(fltMa4Atu, 2) <> fFormataFloat(fltMa4Ant, 2)) And (VS_strTabPrc[4] = 'S')) Or
           ((fFormataFloat(fltMa5Atu, 2) <> fFormataFloat(fltMa5Ant, 2)) And (VS_strTabPrc[5] = 'S')) Or
           ((fFormataFloat(fltMa6Atu, 2) <> fFormataFloat(fltMa6Ant, 2)) And (VS_strTabPrc[6] = 'S')) Or
           ((fFormataFloat(fltMa7Atu, 2) <> fFormataFloat(fltMa7Ant, 2)) And (VS_strTabPrc[7] = 'S')) Or
           ((fFormataFloat(fltVe1Atu, 2) <> fFormataFloat(fltVe1Ant, 2)) And (VS_strTabPrc[1] = 'S')) Or
           ((fFormataFloat(fltVe2Atu, 2) <> fFormataFloat(fltVe2Ant, 2)) And (VS_strTabPrc[2] = 'S')) Or
           ((fFormataFloat(fltVe3Atu, 2) <> fFormataFloat(fltVe3Ant, 2)) And (VS_strTabPrc[3] = 'S')) Or
           ((fFormataFloat(fltVe4Atu, 2) <> fFormataFloat(fltVe4Ant, 2)) And (VS_strTabPrc[4] = 'S')) Or
           ((fFormataFloat(fltVe5Atu, 2) <> fFormataFloat(fltVe5Ant, 2)) And (VS_strTabPrc[5] = 'S')) Or
           ((fFormataFloat(fltVe6Atu, 2) <> fFormataFloat(fltVe6Ant, 2)) And (VS_strTabPrc[6] = 'S')) Or
           ((fFormataFloat(fltVe7Atu, 2) <> fFormataFloat(fltVe7Ant, 2)) And (VS_strTabPrc[7] = 'S')) Then

        Begin
          qryExec := fCriaQuery;
          try
            qryExec.SQL.Text := 'UPDATE ITEGER SET ITE_DALTPR = :DALTPR WHERE ITE_CODITE = :CODITE AND LOCATE(ITE_CODEMP, :CODEMP) > 0';

            strEmpresas := fRetEmpresasUsamPrecoMatriz(Nil, ''{strCodEmp}, ''{strEmpPar}, True{blnSomenteAtivas});

            qryExec.ParamByName('CODEMP').AsString := strCodEmp + '_' + strEmpresas;
            qryExec.ParamByName('CODITE').AsString := strCodIte;
            qryExec.ParamByName('DALTPR').AsDate := fNow;
            qryExec.ExecSQL;
          finally
           {$IFNDEF LINUX}
            FreeAndNil(qryExec);
           {$ENDIF}
          end;
        End;

       {$IFDEF LINUX}
        WriteLog('Precos atualizados do produto "' + strCodIte + '" na empresa "' + strCodEmp + '".');
       {$ENDIF}
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        qryPreAlt.Cancel;
       {$IFDEF LINUX}
        Raise;
       {$ELSE}
				pMensagensErro(E.Message,'[TfrmModuloPreAlt.fGravaPreAlt]');
       {$ENDIF}
      End;
    End;
  End;

  if DataSet = nil then
  begin
    qryPreAlt.Close;
   {$IFNDEF LINUX}
    FreeAndNil(qryPreAlt);
   {$ENDIF}
  end
  else
    qryPreAlt := nil;
end;

function fGravaPreAltCat(qryPreNew: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF}): Boolean;
  Var
    qryIteger: {$IFDEF LINUX} IQuery {$ELSE } TUniQuery{$ENDIF};
Begin
  Result := False;

  qryIteger := fCriaQuery;
  Try
    With qryIteger Do
    Begin
      SQL.Add('SELECT * FROM ITEGER WHERE ITE_CODITE = :CODITE AND ITE_CODEMP = :CODEMP');
      ParamByName('CODITE').AsString := qryPreNew.ParamByName('CODITE').AsString;
      ParamByName('CODEMP').AsString := qryPreNew.ParamByName('CODEMP').AsString;
      Open;
    End;

    If Not qryIteger.IsEmpty Then
    Begin
      With qryPreNew Do
      Begin
        Result := fGravaPreAlt(ParamByName('CODITE').AsString,
                               qryIteger.FieldByName('ITE_PRECUS').AsFloat,
                               ParamByName('PRECUS').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE1').AsFloat,
                               ParamByName('PREVE1').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR1').AsFloat,
                               ParamByName('MARBR1').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE2').AsFloat,
                               ParamByName('PREVE2').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR2').AsFloat,
                               ParamByName('MARBR2').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE3').AsFloat,
                               ParamByName('PREVE3').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR3').AsFloat,
                               ParamByName('MARBR3').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE4').AsFloat,
                               ParamByName('PREVE4').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR4').AsFloat,
                               ParamByName('MARBR4').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE5').AsFloat,
                               ParamByName('PREVE5').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR5').AsFloat,
                               ParamByName('MARBR5').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE6').AsFloat,
                               ParamByName('PREVE6').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR6').AsFloat,
                               ParamByName('MARBR6').AsFloat,
                               qryIteger.FieldByName('ITE_PREVE7').AsFloat,
                               ParamByName('PREVE7').AsFloat,
                               qryIteger.FieldByName('ITE_MARBR7').AsFloat,
                               ParamByName('MARBR7').AsFloat,
                               qryIteger.FieldByName('ITE_PRECOM').AsFloat,
                               ParamByName('PRECOM').AsFloat,
                               'CATALOGO DE PREÇOS',
                               Nil,
                               '',
                               strLoginUsuarioLogado);
        Result := True;
      End;
    End;
  Finally
   {$IFNDEF LINUX}
    FreeAndNil(qryIteger);
   {$ENDIF}
  End;
End;

end.
