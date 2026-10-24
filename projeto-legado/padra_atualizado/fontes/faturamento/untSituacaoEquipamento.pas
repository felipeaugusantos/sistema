unit untSituacaoEquipamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, EditFocus, ComboBoxFocus, Vcl.Mask, MaskEditFocus,
  Data.DB, MemDS, DBAccess, Uni;

type
  TfrmSituacaoEquipamento = class(TfrmPai)
    lblSituacaoEquipamento: TLabel;
    cmbSituacaoEquipamento: TComboBoxFocus;
    lblRetiradoPor: TLabel;
    edtRetiradoPor: TEditFocus;
    mskDtaRetirada: TMaskEditFocus;
    lblDtaRetirada: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure cmbSituacaoEquipamentoChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

    procedure pCarregaSituacaoEquipamento;

    procedure pGravarLogEqp(strCodOpe,
                            strStaAnt,
                            strStaAtu,
                            strNumOse,
                            strCodEmp,
                            strCodDig : String);

    function fGetSituacaoEquipamento(strNumOse, strCodEmp : String) : String;

    function fCamposPreenchidos : Boolean;
    function fStatusAprovado : Boolean;
    function fValidaData : Boolean;
    function fValidaSituacao(strSituacao: String): Boolean;

  public

    strNumOse : String;
    strCodEmp : String;

    strCodDig_Atual : String;
    strStatus_Atual : String;
    strSubSta_Atual : String;
    strGarant       : String;
    strPedFat       : String;

  end;

implementation

uses
  untFuncoesSimples, untLiberacao;

Const
  OS_REALIZADA_ARMAZENADO            = 'SA';
  OS_REALIZADA_RETIRADO_PELO_CLIENTE = 'SR';

  OS_REPROVADA_ARMAZENADO            = 'NA';
  OS_REPROVADA_RETIRADO_PELO_CLIENTE = 'NR';

  ARMAZENADO       = 0;
  RETIRADO_CLIENTE = 1;

{$R *.dfm}

procedure TfrmSituacaoEquipamento.btnConfirmaClick(Sender: TObject);
var
  qryAux          : TUniQuery;
  dtaDataRetirada : TDateTime;
  blnOSAprovada   : Boolean;
  strSitEqu       : String;
  objLiberacao    : TLiberacao;
const
  strSQL = 'UPDATE                  ' +
           '  EQUGER                ' +
           'SET                     ' +
           '  EQU_SITEQU = :SITEQU, ' + // Situação do equipamento
           '  EQU_REAPOR = :REAPOR, ' + // Retirado por:
           '  EQU_SITDTR = :SITDTR, ' + // Data de retirada:
           '  EQU_SUBSTA = :SUBSTA  ' + // Sub-status
           'WHERE                   ' +
           '  EQU_NUMOSE = :NUMOSE AND ' +
           '  EQU_CODEMP = :CODEMP ';
begin

  inherited;

  ModalResult := mrNone;

  If fEmptyStr(strNumOse) Then
    Exit;

  If Not fCamposPreenchidos Then
    Exit;

  TryStrToDate(mskDtaRetirada.Text, dtaDataRetirada);

  blnOSAprovada := fStatusAprovado;

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Add(strSQL);

    If (blnOSAprovada) Then
      qryAux.ParamByName('SITEQU').AsString := IIF(cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE, OS_REALIZADA_RETIRADO_PELO_CLIENTE, OS_REALIZADA_ARMAZENADO)
    Else
      qryAux.ParamByName('SITEQU').AsString := IIF(cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE, OS_REPROVADA_RETIRADO_PELO_CLIENTE, OS_REPROVADA_ARMAZENADO);

    qryAux.ParamByName('REAPOR').Value := IIF(cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE, edtRetiradoPor.Text, Null);
    qryAux.ParamByName('SITDTR').Value := IIF(cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE, dtaDataRetirada    , Null);

    { - "C" -> "DEVOLVIDA AO CLIENTE"}
    { - "A" -> "ARMAZENADA"          }
    qryAux.ParamByName('SUBSTA').AsString := IIF(cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE, 'C', 'A');

    qryAux.ParamByName('NUMOSE').AsString := strNumOse;
    qryAux.ParamByName('CODEMP').AsString := IIF(fEmptyStr(strCodEmp), VS_strCodEmp, strCodEmp);

    {De: Retirado pelo cliente Para: Armazenado - Deve solicitar senha!}
    strSitEqu := fGetSituacaoEquipamento(strNumOse, strCodEmp);

    If ((strSitEqu = OS_REALIZADA_RETIRADO_PELO_CLIENTE) Or
        (strSitEqu = OS_REPROVADA_RETIRADO_PELO_CLIENTE)) And
       ((qryAux.ParamByName('SITEQU').AsString = OS_REALIZADA_ARMAZENADO) Or
        (qryAux.ParamByName('SITEQU').AsString = OS_REPROVADA_ARMAZENADO)) Then
    Begin

      objLiberacao := TLiberacao.Create;

      Try

        objLiberacao.Clear;
        objLiberacao.objMsgLibera.pAddTexto('A T E N C A O - Permitir alterar a situação do equipamento de "Retirado pelo Cliente" para "Armazenado"?');

        objLiberacao.strDirAce  := 'SITEQP';
        objLiberacao.strCodOpe  := strLoginUsuarioLogado;
        objLiberacao.strMsgSen  := 'Permitir alterar a situação do equipamento de "Retirado pelo Cliente" para "Armazenado"?';
        objLiberacao.pInformaNumDocEspDocCodEmp(strNumOse, 'OS', strCodEmp);

        If Not objLiberacao.fLibera Then
          Exit;
      Finally
        FreeAndNil(objLiberacao);
      End;

    End;

    If fValidaSituacao(qryAux.ParamByName('SITEQU').AsString) then
    Begin
      fMensagem('ATENÇÃO', 'Só é possível alterar a situação do equipamento para "Retirado pelo Cliente" nas situações abaixo:' + #13 +
                'REALIZADA (FATURADAS)' + #13 +
                'REPROVADA' + #13 +
                'GARANTIA (LOJA OU FABRICA)', ['&Ok']);
      Exit;
    End;

    Try

      fStartTransaction;

      qryAux.ExecSQL;

      pGravarLogEqp(strLoginUsuarioLogado,
                    strSitEqu,
                    qryAux.ParamByName('SITEQU').AsString,
                    strNumOse,
                    strCodEmp,
                    strCodDig_Atual);

      fCommit;

    Except
      On E: Exception Do
        pMensagensErro(E.Message, '[btnConfirmaClick(Sender: TObject)]');
    End;

  Finally
    FreeAndNil(qryAux);
  End;

  ModalResult := mrOk;

end;

procedure TfrmSituacaoEquipamento.btnSairClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrClose;
end;

procedure TfrmSituacaoEquipamento.cmbSituacaoEquipamentoChange(Sender: TObject);
begin
  inherited;

  lblRetiradoPor.Visible := cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE;
  edtRetiradoPor.Visible := cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE;

  lblDtaRetirada.Visible := cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE;
  mskDtaRetirada.Visible := cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE;

end;

function TfrmSituacaoEquipamento.fGetSituacaoEquipamento(strNumOse, strCodEmp: String): String;
var
  qryAux : TUniQuery;
const
  strSQL = 'SELECT EQU_SITEQU FROM EQUGER WHERE EQU_NUMOSE = :NUMOSE AND EQU_CODEMP = :CODEMP';
begin

  Result := '';

  If fEmptyStr(strNumOse) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMOSE').AsString := strNumOse;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
      Result := qryAux.FieldByName('EQU_SITEQU').AsString;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmSituacaoEquipamento.FormCreate(Sender: TObject);
begin
  inherited;
  cmbSituacaoEquipamento.ItemIndex := -1;
  edtRetiradoPor.Clear;
  mskDtaRetirada.Clear;
end;

procedure TfrmSituacaoEquipamento.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaSituacaoEquipamento;
end;

function TfrmSituacaoEquipamento.fStatusAprovado: Boolean;
begin

  Result := False;

  If (strStatus_Atual = 'A') Then
    Exit(True);

  If (strStatus_Atual = 'M') Then
    Exit(True);

  If (strStatus_Atual = 'R') Then
    Exit(True);

end;

function TfrmSituacaoEquipamento.fValidaData: Boolean;
Var
  dtaDataRetirada : TDateTime;
begin

  Result := True;

  If fEmptyStr(mskDtaRetirada.Text) Then
    Exit(False);

  If (Not TryStrToDate(mskDtaRetirada.Text, dtaDataRetirada)) Then
    Exit(False);

end;

function TfrmSituacaoEquipamento.fValidaSituacao(strSituacao: String): Boolean;
begin
  Result := False;

  If (strSituacao <> OS_REALIZADA_RETIRADO_PELO_CLIENTE) Then
    Exit;

  If (strGarant <> 'N') Then
    Exit;

  If (strPedFat = 'FATURADAS') Then
    Exit;

  If (strPedFat = 'PARCIALMENTE FATURADAS') Then
    Exit;

  Result := True;
end;

function TfrmSituacaoEquipamento.fCamposPreenchidos: Boolean;
begin

  Result := True;

  If fEmptyStr(cmbSituacaoEquipamento.Text) Then
  Begin
    fMensagem('Atenção', 'Informe o campo "Situação do equipamento"!', ['&Ok']);
    pSetFocus(cmbSituacaoEquipamento);
    Exit(False);
  End;

  If (cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE) Then
    If fEmptyStr(edtRetiradoPor.Text) Then
    Begin
      fMensagem('Atenção', 'Informe o campo "Retirado por"!', ['&Ok']);
      pSetFocus(edtRetiradoPor);
      Exit(False);
    End;

  If (cmbSituacaoEquipamento.ItemIndex = RETIRADO_CLIENTE) Then
    If Not fValidaData Then
    Begin
      fMensagem('Atenção', 'Informe o campo "Data de Retirada" com uma data válida!', ['&Ok']);
      pSetFocus(mskDtaRetirada);
      Exit(False);
    End;

end;

procedure TfrmSituacaoEquipamento.pCarregaSituacaoEquipamento;
var
  qryAux : TUniQuery;
const
  strSQL = 'SELECT        ' +
           '  EQU_SITEQU, ' +
           '  EQU_REAPOR, ' +
           '  EQU_SITDTR, ' +
           '  EQU_STATUS, ' +
           '  EQU_SUBSTA, ' +
           '  EQU_CODDIG, ' +
           '  EQU_GARANT, ' +
           '  CASE        ' +
           '    WHEN (EQU_STATUS = "R") AND ' +
           '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
           '           FROM FATDOR F ' +
           '           WHERE (FDO_JAFATU = 1) '+
           '             AND (FDO_NUMDOC = EQU_NUMPED) ' +
           '             AND (FDO_ESPDOC = EQU_TIPPED) ' +
           '             AND (FDO_CODEMP = EQU_EMPPED)) = 0) THEN "NÃO FATURADAS" ' +
           '    WHEN (EQU_STATUS = "R") AND '  +
           '         ((SELECT DISTINCT FGO_JAFATU '  +
           '           FROM FATGOR F ' +
           '           WHERE (FGO_NUMDOC = EQU_NUMPED) '  +
           '             AND (FGO_ESPDOC = EQU_TIPPED) '  +
           '             AND (FGO_CODEMP = EQU_EMPPED)) = 1) THEN "FATURADAS" '  +
           '    WHEN (EQU_STATUS = "R") AND ' +
           '         ((SELECT COUNT(DISTINCT FDO_JAFATU) ' +
           '           FROM FATDOR F ' +
           '           WHERE (FDO_NUMDOC = EQU_NUMPED) ' +
           '             AND (FDO_ESPDOC = EQU_TIPPED) ' +
           '             AND (FDO_CODEMP = EQU_EMPPED)) = 2) THEN "PARCIALMENTE FATURADAS" ' +
           '    ELSE "" END PEDFAT ' +
           'FROM          ' +
           '  EQUGER      ' +
           'WHERE         ' +
           '  EQU_NUMOSE = :NUMOSE AND ' +
           '  EQU_CODEMP = :CODEMP     ';
begin

  If fEmptyStr(strNumOse) Then
    Exit;

  If fEmptyStr(strCodEmp) Then
    Exit;

  qryAux := fCriaQuery(Self);

  Try

    qryAux.Close;
    qryAux.SQL.Add(strSQL);
    qryAux.ParamByName('NUMOSE').AsString := strNumOse;
    qryAux.ParamByName('CODEMP').AsString := strCodEmp;
    qryAux.Open;

    If Not qryAux.IsEmpty Then
    Begin

      strStatus_Atual := qryAux.FieldByName('EQU_STATUS').AsString;
      strSubSta_Atual := qryAux.FieldByName('EQU_SUBSTA').AsString;
      strCodDig_Atual := qryAux.FieldByName('EQU_CODDIG').AsString;
      strGarant       := qryAux.FieldByName('EQU_GARANT').AsString;
      strPedFat       := qryAux.FieldByName('PEDFAT').AsString;

      If (qryAux.FieldByName('EQU_SITEQU').AsString = OS_REALIZADA_ARMAZENADO) Or
         (qryAux.FieldByName('EQU_SITEQU').AsString = OS_REPROVADA_ARMAZENADO) Then
      Begin
        cmbSituacaoEquipamento.ItemIndex := ARMAZENADO;
        edtRetiradoPor.Clear;
        mskDtaRetirada.Clear;
      End

      Else

      If (qryAux.FieldByName('EQU_SITEQU').AsString = OS_REALIZADA_RETIRADO_PELO_CLIENTE) Or
         (qryAux.FieldByName('EQU_SITEQU').AsString = OS_REPROVADA_RETIRADO_PELO_CLIENTE) Then
      Begin
        cmbSituacaoEquipamento.ItemIndex := RETIRADO_CLIENTE;
        edtRetiradoPor.Text := qryAux.FieldByName('EQU_REAPOR').AsString;
        mskDtaRetirada.Text := qryAux.FieldByName('EQU_SITDTR').AsString;
      End;

      cmbSituacaoEquipamentoChange(Self);

    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

procedure TfrmSituacaoEquipamento.pGravarLogEqp(strCodOpe,
                                                strStaAnt,
                                                strStaAtu,
                                                strNumOse,
                                                strCodEmp,
                                                strCodDig : String);
Var
  strSQL : String;
  qryGen : TUniQuery;
Begin

  If (strStaAnt <> strStaAtu) Then
  Begin

    qryGen := fCriaQuery;

    Try

      strSQL := '';
      strSQL := strSQL + 'INSERT INTO     ';
      strSQL := strSQL + '  LOGEQP(       ';
      strSQL := strSQL + '    AUTOINCREM, ';
      strSQL := strSQL + '    LOG_DTALOG, ';
      strSQL := strSQL + '    LOG_HORLOG, ';
      strSQL := strSQL + '    LOG_CODEMP, ';
      strSQL := strSQL + '    LOG_CODOPE, ';
      strSQL := strSQL + '    LOG_STAANT, ';
      strSQL := strSQL + '    LOG_STAATU, ';
      strSQL := strSQL + '    LOG_NUMOSE, ';
      strSQL := strSQL + '    LOG_CODDIG) ';
      strSQL := strSQL + '  VALUES (      ';
      strSQL := strSQL + '    :AUTINC,    ';
      strSQL := strSQL + '    :DTALOG,    ';
      strSQL := strSQL + '    :HORLOG,    ';
      strSQL := strSQL + '    :CODEMP,    ';
      strSQL := strSQL + '    :CODOPE,    ';
      strSQL := strSQL + '    :STAANT,    ';
      strSQL := strSQL + '    :STAATU,    ';
      strSQL := strSQL + '    :NUMOSE,    ';
      strSQL := strSQL + '    :CODDIG)    ';

      qryGen.Close;
      qryGen.SQL.Clear;
      qryGen.SQL.Add(strSQL);

      qryGen.ParamByName('AUTINC').AsString   := fRetAutoIncrem('LOGEQP', strCodEmp);
      qryGen.ParamByName('DTALOG').AsDate     := VS_date;
      qryGen.ParamByName('HORLOG').AsDateTime := fTime();
      qryGen.ParamByName('CODEMP').AsString   := strCodEmp;
      qryGen.ParamByName('CODOPE').AsString   := strCodOpe;
      qryGen.ParamByName('STAANT').AsString   := strStaAnt;
      qryGen.ParamByName('STAATU').AsString   := strStaAtu;
      qryGen.ParamByName('NUMOSE').AsString   := strNumOse;

      If fEmptyStr(strCodDig) Then
        qryGen.ParamByName('CODDIG').Value    := Null
      Else
        qryGen.ParamByName('CODDIG').AsString := strCodDig;

      qryGen.ExecSQL;

    Finally
      FreeAndNil(qryGen);
    End;

  End;

end;

end.
