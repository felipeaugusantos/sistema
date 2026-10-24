unit untCfgSMSAviCob;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxClasses,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridCustomView,
  cxGridCitel, cxGridLevel, cxGrid, cxCheckBox, cxButtonEdit, cxDropDownEdit,
  Uni, UniClientDataSet, UniDataSetProvider, cxRadioGroup, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmCfgSMSAviCob = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitelTableView: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    ATIVO: TcxGridDBColumn;
    DESCRIÇÃO: TcxGridDBColumn;
    EDITOR: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GRUPO: TcxGridDBColumn;
    dtsSMSSAI: TDataSource;
    procedure EDITORPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ENVIOPropertiesChange(Sender: TObject);
  private

    arrCodSmsEma: Array Of String;
    arrDesSmsEma: Array Of String;
    arrTamSmsEma: Array Of Integer;
    arrCodSMSSAI: Array Of String;
    arrDesSMSSAI: Array Of String;

    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    dspCfgEma: TUniDataSetProvider;
    qryTemp  : TUniQuery;

    FMostraAvisoProximoDiaUtil: Boolean;

    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fRetEspecieDocumento(strCodGru: String): String;
    procedure pCriarConfiguracoesPadrao;
    procedure pInicializarQuery;
    procedure pIncluirRegistroSmsEma(strCodGru, strDesGru: String);
    function fExisteSmsEma(strCodGru: String): Boolean;
    function fExisteSMSSAI(strCodGru, strCodigo: String): Boolean;
    procedure pIncluirRegistroSMSSAI(strCodigo, strCodGru, strDescri: String);
    procedure pAdicionarOpcao(FCodSMSSAI,FDesSMSSAI: String);
  public
    { Public declarations }
    blnAntes : Boolean;

    property MostraAvisoProximoDiaUtil: Boolean read FMostraAvisoProximoDiaUtil write FMostraAvisoProximoDiaUtil Default False;
  end;

var
  frmCfgSMSAviCob: TfrmCfgSMSAviCob;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgModeloSMS, untCfgPortadoresAutorizadosEmail;

procedure TfrmCfgSMSAviCob.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmCfgSMSAviCob.EDITORPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    frmCfgPortadoresAutorizadosEmail: TfrmCfgPortadoresAutorizadosEmail;
begin
  inherited;

  If AButtonIndex = 0 Then
  Begin
     Try
       pCriarFormularios(TfrmCfgModeloSMS, frmCfgModeloSMS);
       frmCfgModeloSMS.Caption   := frmCfgModeloSMS.Caption + ' - ' + dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString;
       frmCfgModeloSMS.strSeqGer := dtsSMSSAI.DataSet.FieldByName('AUTOIN').AsString;
       frmCfgModeloSMS.strEspDoc := fRetEspecieDocumento(dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString);
       frmCfgModeloSMS.strCodGru := dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString;
       frmCfgModeloSMS.ShowModal();
     Finally
       pFreeAndNil(frmCfgModeloSMS);
     End;
  End
  Else //Portadores Autorizados
  If AButtonIndex = 1 Then
  Begin
     Try
        pCriarFormularios(TfrmCfgPortadoresAutorizadosEmail, frmCfgPortadoresAutorizadosEmail);
        frmCfgPortadoresAutorizadosEmail.Caption   := frmCfgPortadoresAutorizadosEmail.Caption + ' - ' + dtsSMSSAI.DataSet.FieldByName('DESCRI').AsString;
        frmCfgPortadoresAutorizadosEmail.strSeqGer := dtsSMSSAI.DataSet.FieldByName('CODSMS').AsString;
        frmCfgPortadoresAutorizadosEmail.strCodGru := dtsSMSSAI.DataSet.FieldByName('CODGRU').AsString;
        frmCfgPortadoresAutorizadosEmail.intCodTip := 1;
        frmCfgPortadoresAutorizadosEmail.ShowModal();
     Finally
        pFreeAndNil(frmCfgPortadoresAutorizadosEmail);
     End;
  End

end;

procedure TfrmCfgSMSAviCob.ENVIOPropertiesChange(Sender: TObject);
begin
  inherited;

  If (dtsSMSSAI.DataSet.State = dsEdit) Then
    dtsSMSSAI.DataSet.Post;
end;

function TfrmCfgSMSAviCob.fExisteSmsEma(strCodGru: String): Boolean;
begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'GRUSMS',
                                          ['GRU_CODGRU'],
                                          [strCodGru]) ) );
end;

function TfrmCfgSMSAviCob.fExisteSMSSAI(strCodGru, strCodigo: String): Boolean;
begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'SMSSAI',
                                          ['SMS_CODIGO', 'SMS_CODGRU', 'SMS_CODEMP'],
                                          [strCodigo, strCodGru, VS_strCodEmp]) ) );
end;

procedure TfrmCfgSMSAviCob.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgEma);
  FreeAndNil(dspCfgEma);
  FreeAndNil(cdsCfgEma);
end;

procedure TfrmCfgSMSAviCob.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
  dspCfgEma := TUniDataSetProvider.Create(Self);
  cdsCfgEma := TUniClientDataSet.Create(Self);

  dspCfgEma.DataSet := qryCfgEma;
  cdsCfgEma.SetProvider(dspCfgEma);

  dtsSMSSAI.DataSet := cdsCfgEma;
  pCarregaConfiguracoes;
  cxGridCitelTableView.ViewData.Expand(True);
end;

function TfrmCfgSMSAviCob.fRetEspecieDocumento(strCodGru: String): String;
begin
  Result := '';

  If (strCodGru = '009') Then
    Result := 'AC'

end;

procedure TfrmCfgSMSAviCob.pAdicionarOpcao(FCodSMSSAI,FDesSMSSAI: String);
begin
  // Codigo do Grupo
  SetLength(arrCodSmsEma, 1);
  arrCodSmsEma[0] := '009';

  // Descrição do Grupo
  SetLength(arrDesSmsEma,1);
  arrDesSmsEma[0] := 'Avisos de Cobrança';

  // Código das opção por grupo
  SetLength(arrCodSMSSAI, Length(arrCodSMSSAI) + 1);
  arrCodSMSSAI[Length(arrCodSMSSAI)-1] := FCodSMSSAI;

  // Descrição das opção
  SetLength(arrDesSMSSAI, Length(arrDesSMSSAI) + 1);
  arrDesSMSSAI[Length(arrDesSMSSAI)-1] := FDesSMSSAI;

  // Quantidade de opção
  SetLength(arrTamSmsEma, 1);
  arrTamSmsEma[0] := Length(arrCodSMSSAI);
end;

procedure TfrmCfgSMSAviCob.pCarregaConfiguracoes;
Var
  strSQL: String;
  strLike : String;
begin
   strLike := IIF(blnAntes,'Antes','Apos');
  //rotina responsável pela criação dos grupos
  //e gatilhos padrão para a empresa logada
  pCriarConfiguracoesPadrao();

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  SMS_CODIGO        AS CODSMS, ';
    strSQL := strSQL + '  SMS_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  SMS_STATUS        AS STATUS, ';
    strSQL := strSQL + '  SMS_DESCRI        AS DESCRI, ';
    strSQL := strSQL + '  SMS_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  SMS_MDROBO        AS MDROBO, ';
    strSQL := strSQL + '  SMSSAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  SMSSAI  ';
    strSQL := strSQL + '  INNER JOIN GRUSMS ON GRU_CODGRU = SMS_CODGRU ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP AND GRU_CODGRU = "009"  ';
    strSQL := strSQL + '  AND SMS_DESCRI LIKE "%'+strLike+'%" ';

    If Not FMostraAvisoProximoDiaUtil Then
      strSQL := strSQL + ' AND SMS_CODIGO NOT IN ("023", "024") ';

    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  SMS_DESCRI  ';

    qryCfgEma.Close;
    qryCfgEma.SQL.Clear;
    qryCfgEma.SQL.Add(strSQL);
    qryCfgEma.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgEma.Open;
    pSetaClient(qryCfgEma);
    cdsCfgEma.Open;
    pSetaClient(cdsCfgEma);

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgSMSAviCob.pCarregaConfiguracoes]');
  End;

end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgSMSAviCob.pCriarConfiguracoesPadrao;
  Var
    i, j, k: Integer;
begin
  Try
    // OPÇÕES ANTES DO VENCIMENTO
    pAdicionarOpcao('004','Aviso de cobrança 1 dia antes do vencimento');
    pAdicionarOpcao('001','Aviso de cobrança 2 dias antes do vencimento');
    pAdicionarOpcao('005','Aviso de cobrança 3 dias antes do vencimento');
    pAdicionarOpcao('006','Aviso de cobrança 4 dias antes do vencimento');
    pAdicionarOpcao('007','Aviso de cobrança 5 dias antes do vencimento');

    // OPÇÕES APÓS O VENCIMENTO
    pAdicionarOpcao('008','Aviso de cobrança 1 dias após vencimento');
    pAdicionarOpcao('009','Aviso de cobrança 2 dias após vencimento');
    pAdicionarOpcao('002','Aviso de cobrança 3 dias após vencimento');
    pAdicionarOpcao('010','Aviso de cobrança 4 dias após vencimento');
    pAdicionarOpcao('003','Aviso de cobrança 5 dias após vencimento');


    k := 0;
    pInicializarQuery();

    Try
      fStartTransaction();

      For i := 0 To (Length(arrCodSmsEma) - 1) Do
      Begin

        If (Not fExisteSmsEma(arrCodSmsEma[i])) Then
          pIncluirRegistroSmsEma(arrCodSmsEma[i], arrDesSmsEma[i]);

        For j := 0 To (arrTamSmsEma[i] - 1) Do
        Begin
          If (Not fExisteSMSSAI(arrCodSmsEma[i], arrCodSMSSAI[k])) Then
            pIncluirRegistroSMSSAI(arrCodSMSSAI[k], arrCodSmsEma[i], arrDesSMSSAI[k]);

          Inc(k);
        End;
      End;

	    fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgSMSAviCob.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;


end;

procedure TfrmCfgSMSAviCob.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin

  Try

    qryGravar := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE           ';
    strSQL := strSQL + '  SMSSAI         ';
    strSQL := strSQL + 'SET              ';
    strSQL := strSQL + '  SMS_MDROBO = :MDROBO, ';
    strSQL := strSQL + '  SMS_STATUS = :STATUS  ';
    strSQL := strSQL + 'WHERE            ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
    strSQL := strSQL + '  SMS_CODEMP = :CODEMP     ';

    cdsCfgEma.First;

    While Not cdsCfgEma.Eof Do
    Begin
      qryGravar.Close;
      qryGravar.SQL.Clear;
      qryGravar.SQL.Add(strSQL);
      qryGravar.ParamByName('STATUS').AsString := cdsCfgEma.FieldByName('STATUS').AsString;
      qryGravar.ParamByName('AUTOIN').AsString := cdsCfgEma.FieldByName('AUTOIN').AsString;
      qryGravar.ParamByName('CODEMP').AsString := cdsCfgEma.FieldByName('CODEMP').AsString;
      qryGravar.ParamByName('MDROBO').AsString := cdsCfgEma.FieldByName('MDROBO').AsString;
      qryGravar.ExecSQL;
      cdsCfgEma.Next;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgSMSAviCob.pGravar]')
  End;

  FreeAndNil(qryGravar);

end;

procedure TfrmCfgSMSAviCob.pIncluirRegistroSmsEma(strCodGru, strDesGru: String);
begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := 'INSERT INTO GRUSMS (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU) ' +
    ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU)';

  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUSMS', VS_strCodEmp);
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESGRU').AsString := strDesGru;
  qryTemp.ExecSQL();
end;

procedure TfrmCfgSMSAviCob.pIncluirRegistroSMSSAI(strCodigo, strCodGru,
  strDescri: String);
begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := 'INSERT INTO SMSSAI (AUTOINCREM, SMS_CODIGO, SMS_CODGRU, SMS_CODEMP, SMS_DESCRI, ' +
    'SMS_STATUS, SMS_ORDENA, SMS_MDROBO) VALUES (:AUTINC, :CODIGO, :CODGRU, :CODEMP, :DESCRI, ' +
    ':STATUS, :ORDENA, :MDROBO)';

  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('SMSSAI', VS_strCodEmp);
  qryTemp.ParamByName('CODIGO').AsString := strCodigo;
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESCRI').AsString := strDescri;
  qryTemp.ParamByName('STATUS').AsString := 'I';
  qryTemp.ParamByName('ORDENA').AsString := strCodigo;
  qryTemp.ParamByName('MDROBO').AsString := 'N';
  qryTemp.ExecSQL();
end;

procedure TfrmCfgSMSAviCob.pInicializarQuery;
begin
  qryTemp := fCriaQuery(nil);
  qryTemp.Close();
  qryTemp.SQL.Clear();
end;

end.
