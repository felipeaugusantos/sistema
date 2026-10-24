unit untCfgEmailAviCob;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, cxEditRepositoryItems;

type
  TfrmCfgEmailAviCob = class(TfrmPaiConfirma)
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
    dtsEmaSAI: TDataSource;
    ENVIO: TcxGridDBColumn;
    procedure EDITORPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ENVIOPropertiesChange(Sender: TObject);
    procedure ENVIOPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
  private

    arrCodGruEma: Array Of String;
    arrDesGruEma: Array Of String;
    arrTamGruEma: Array Of Integer;
    arrCodEmaSAI: Array Of String;
    arrDesEmaSAI: Array Of String;

    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    dspCfgEma: TUniDataSetProvider;
    qryTemp  : TUniQuery;

    FMostraAvisoProximoDiaUtil: Boolean;

    procedure pCarregaConfiguracoes;
    procedure pGravar;
    procedure pCriarConfiguracoesPadrao;
    procedure pInicializarQuery;
    procedure pAdicionarOpcao(FCodEmaSAI,FDesEmaSAI: String);
    procedure pIncluirRegistroEmaSai(strCodigo, strCodGru, strDescri: String);
    procedure pIncluirRegistroGruEma(strCodGru, strDesGru: String);

    procedure ValidaSeTodosAtivosPossuemEmailConfigurado;

    function fRetEspecieDocumento(strCodGru: String): String;
    function fExisteGruEma(strCodGru: String): Boolean;
    function fExisteEmaSAI(strCodGru, strCodigo: String): Boolean;

  public
    { Public declarations }
    blnAntes : Boolean;

    property MostraAvisoProximoDiaUtil: Boolean read FMostraAvisoProximoDiaUtil write FMostraAvisoProximoDiaUtil Default False;
  end;

var
  frmCfgEmailAviCob: TfrmCfgEmailAviCob;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgModeloEmail, untCfgPortadoresAutorizadosEmail,
     untCfgEmailAutenticacao, untCfgClientesEmail;

procedure TfrmCfgEmailAviCob.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmCfgEmailAviCob.EDITORPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
  Var
    frmCfgClientesEmail: TfrmCfgClientesEmail;
    frmCfgPortadoresAutorizadosEmail: TfrmCfgPortadoresAutorizadosEmail;
begin
  inherited;
  If AButtonIndex = 0 Then //Editar Email
  Begin
    pCriarFormularios(TfrmCfgModeloEmail, frmCfgModeloEmail);
    frmCfgModeloEmail.Caption   := frmCfgModeloEmail.Caption + ' - ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgModeloEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgModeloEmail.strEspDoc := fRetEspecieDocumento(dtsEmaSai.DataSet.FieldByName('CODGRU').AsString);
    frmCfgModeloEmail.ShowModal();
    pFreeAndNil(frmCfgModeloEmail);
  End
  Else //Portadores Autorizados
  If AButtonIndex = 1 Then
  Begin
    pCriarFormularios(TfrmCfgPortadoresAutorizadosEmail, frmCfgPortadoresAutorizadosEmail);
    frmCfgPortadoresAutorizadosEmail.Caption   := dtsEmaSai.DataSet.FieldByName('GRUPOS').AsString + ' | ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgPortadoresAutorizadosEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgPortadoresAutorizadosEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgPortadoresAutorizadosEmail.intCodTip := 0;
    frmCfgPortadoresAutorizadosEmail.ShowModal();
    pFreeAndNil(frmCfgPortadoresAutorizadosEmail);
  End
  Else //Editar Clientes
  If AButtonIndex = 2 Then //Editar Email
  Begin
    pCriarFormularios(TfrmCfgClientesEmail, frmCfgClientesEmail);
    frmCfgClientesEmail.Caption := dtsEmaSai.DataSet.FieldByName('GRUPOS').AsString + ' | ' + dtsEmaSai.DataSet.FieldByName('DESCRI').AsString;
    frmCfgClientesEmail.strSeqGer := dtsEmaSai.DataSet.FieldByName('CODEMA').AsString;
    frmCfgClientesEmail.strCodGru := dtsEmaSai.DataSet.FieldByName('CODGRU').AsString;
    frmCfgClientesEmail.ShowModal();
    pFreeAndNil(frmCfgClientesEmail);
  End;
end;

procedure TfrmCfgEmailAviCob.ENVIOPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;
  If (dtsEmaSai.DataSet.State <> dsEdit) Then
    dtsEmaSai.DataSet.Edit;

  dtsEmaSai.DataSet.Fieldbyname('PROENV').AsString := 'F';
  dtsEmaSai.DataSet.Post;

  Try
    pCriarFormularios(TfrmCfgEmailAutenticacao, frmCfgEmailAutenticacao);
    frmCfgEmailAutenticacao.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
    frmCfgEmailAutenticacao.ShowModal();
  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.ENVIOPropertiesChange]');
  End;

  pFreeAndNil(frmCfgEmailAutenticacao);
end;

procedure TfrmCfgEmailAviCob.ENVIOPropertiesChange(Sender: TObject);
begin
  inherited;

  {If (dtsEmaSai.DataSet.Fieldbyname('CODGRU').AsString = '009') And
     (dtsEmaSai.DataSet.Fieldbyname('PROENV').AsString <> 'F') Then
  Begin
    dtsEmaSai.DataSet.Fieldbyname('PROENV').Clear;
    fMensagem('ATENÇÃO', 'A forma de envio dos itens no grupo 009 devem ser apenas por "Email Fixo"', ['&OK'], 0);
    Exit;
  End;

  If (dtsEmaSai.DataSet.State = dsEdit) Then
    dtsEmaSai.DataSet.Post;

  If dtsEmaSai.DataSet.Fieldbyname('PROENV').AsString = 'F' Then
  Begin
    Try
      pCriarFormularios(TfrmCfgEmailAutenticacao, frmCfgEmailAutenticacao);
      frmCfgEmailAutenticacao.strSeqGer := dtsEmaSai.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgEmailAutenticacao.ShowModal();
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgEmailAutSaida.ENVIOPropertiesChange]');
    End;

    pFreeAndNil(frmCfgEmailAutenticacao);

  End;}

end;

function TfrmCfgEmailAviCob.fExisteGruEma(strCodGru: String): Boolean; begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'GRUEMA',
                                          ['GRU_ENTSAI', 'GRU_CODGRU'],
                                          ['S', strCodGru]) ) );
end;

function TfrmCfgEmailAviCob.fExisteEmaSai(strCodGru, strCodigo: String): Boolean; begin
  Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                          'EMASAI',
                                          ['EMA_CODIGO', 'EMA_ENTSAI', 'EMA_CODGRU', 'EMA_CODEMP'],
                                          [strCodigo, 'S', strCodGru, VS_strCodEmp]) ) );
end;

procedure TfrmCfgEmailAviCob.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgEma);
  FreeAndNil(dspCfgEma);
  FreeAndNil(cdsCfgEma);
end;

procedure TfrmCfgEmailAviCob.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
  dspCfgEma := TUniDataSetProvider.Create(Self);
  cdsCfgEma := TUniClientDataSet.Create(Self);

  dspCfgEma.DataSet := qryCfgEma;
  cdsCfgEma.SetProvider(dspCfgEma);

  dtsEmaSAI.DataSet := cdsCfgEma;
  pCarregaConfiguracoes;
  cxGridCitelTableView.ViewData.Expand(True);
end;

function TfrmCfgEmailAviCob.fRetEspecieDocumento(strCodGru: String): String;
begin
  Result := '';

  If (strCodGru = '009') Then
    Result := 'AC'

end;

procedure TfrmCfgEmailAviCob.pAdicionarOpcao(FCodEmaSAI,FDesEmaSAI: String);
begin
  // Codigo do Grupo
  SetLength(arrCodGruEma, 1);
  arrCodGruEma[0] := '009';

  // Descrição do Grupo
  SetLength(arrDesGruEma,1);
  arrDesGruEma[0] := 'Avisos de Cobrança';

  // Código das opção por grupo
  SetLength(arrCodEmaSai, Length(arrCodEmaSai) + 1);
  arrCodEmaSai[Length(arrCodEmaSai)-1] := FCodEmaSAI;

  // Descrição das opção
  SetLength(arrDesEmaSai, Length(arrDesEmaSai) + 1);
  arrDesEmaSai[Length(arrDesEmaSai)-1] := FDesEmaSAI;

  // Quantidade de opção
  SetLength(arrTamGruEma, 1);
  arrTamGruEma[0] := Length(arrCodEmaSAI);
end;

procedure TfrmCfgEmailAviCob.pCarregaConfiguracoes;
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
    strSQL := strSQL + '  EMA_CODIGO        AS CODEMA, ';
    strSQL := strSQL + '  EMA_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  EMA_STATUS        AS STATUS, ';
    strSQL := strSQL + '  EMA_DESCRI        AS DESCRI, ';
    strSQL := strSQL + '  IF(GRU_CODGRU="009", "F", EMA_PROENV) AS PROENV, ';
    strSQL := strSQL + '  EMA_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  EMA_MDROBO        AS MDROBO, ';
    strSQL := strSQL + '  EMASAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  EMASAI  ';
    strSQL := strSQL + '  INNER JOIN GRUEMA ON GRU_ENTSAI = EMA_ENTSAI ';
    strSQL := strSQL + '         AND GRU_CODGRU = EMA_CODGRU ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_ENTSAI = :ENTSAI AND ';
    strSQL := strSQL + '  GRU_CODGRU = "009" AND   ';
    strSQL := strSQL + '  EMA_DESCRI LIKE "%'+strLike+'%" ';

    If Not FMostraAvisoProximoDiaUtil Then
      strSQL := strSQL + ' AND EMA_CODIGO NOT IN ("023", "024") ';

    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  EMA_DESCRI  ';

    qryCfgEma.Close;
    qryCfgEma.SQL.Clear;
    qryCfgEma.SQL.Add(strSQL);
    qryCfgEma.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryCfgEma.ParamByName('ENTSAI').AsString := 'S';
    qryCfgEma.Open;
    pSetaClient(qryCfgEma);
    cdsCfgEma.Open;
    pSetaClient(cdsCfgEma);

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAviCob.pCarregaConfiguracoes]');
  End;

end;

{ ************************************************ }
{ SEMPRE QUE UM NOVO GRUPO OU UM NOVO GATILHO      }
{ FOR CRIADO O INSERT DEVERÁ SER INSERIDO AQUI     }
{ PARA A CRIAÇÃO NA EMPRESA LOGADA CASO NÃO EXISTA }
{ *********************************************DF* }
procedure TfrmCfgEmailAviCob.pCriarConfiguracoesPadrao;
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
    pAdicionarOpcao('011','Aviso de cobrança 8 dias após vencimento');

    k := 0;
    pInicializarQuery();

    Try

      For i := 0 To (Length(arrCodGruEma) - 1) Do
      Begin

        If (Not fExisteGruEma(arrCodGruEma[i])) Then
          pIncluirRegistroGruEma(arrCodGruEma[i], arrDesGruEma[i]);

        For j := 0 To (arrTamGruEma[i] - 1) Do
        Begin
          If (Not fExisteEmaSAI(arrCodGruEma[i], arrCodEmaSai[k])) Then
            pIncluirRegistroEmaSAI(arrCodEmaSai[k], arrCodGruEma[i], arrDesEmaSai[k]);

          Inc(k);
        End;

      End;

	    fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgEmailAviCob.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;

end;

procedure TfrmCfgEmailAviCob.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin

  Try
    fStartTransaction;

    qryGravar := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE           ';
    strSQL := strSQL + '  EMASAI         ';
    strSQL := strSQL + 'SET              ';
    strSQL := strSQL + '  EMA_MDROBO = :MDROBO, ';
    strSQL := strSQL + '  EMA_STATUS = :STATUS, ';
    strSQL := strSQL + '  EMA_PROENV = :PROENV  ';
    strSQL := strSQL + 'WHERE            ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP     ';

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
      qryGravar.ParamByName('PROENV').AsString := IIF(fEmptyStr(cdsCfgEma.FieldByName('PROENV').AsString),'F',cdsCfgEma.FieldByName('PROENV').AsString);
      qryGravar.ExecSQL;
      cdsCfgEma.Next;
    End;

    fCommit;

    ValidaSeTodosAtivosPossuemEmailConfigurado;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(e.Message, '[TfrmCfgEmailAviCob.pGravar]');
    End;
  End;

  FreeAndNil(qryGravar);

end;

procedure TfrmCfgEmailAviCob.pIncluirRegistroGruEma(strCodGru, strDesGru: String); begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := 'INSERT INTO GRUEMA (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU) ' +
                      ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU)';
  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUEMA', VS_strCodEmp);
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESGRU').AsString := strDesGru;
  qryTemp.ExecSQL();
end;

procedure TfrmCfgEmailAviCob.pIncluirRegistroEmaSai(strCodigo, strCodGru, strDescri: String);
begin
  qryTemp.Close();
  qryTemp.SQL.Clear();
  qryTemp.SQL.Text := 'INSERT INTO EMASAI (AUTOINCREM, EMA_CODIGO, EMA_CODGRU, EMA_CODEMP, EMA_DESCRI, ' +
                      'EMA_PROENV, EMA_STATUS, EMA_ORDENA, EMA_MDROBO) VALUES (:AUTINC, :CODIGO, :CODGRU, :CODEMP, :DESCRI, ' +
                      ':PROENV, :STATUS, :ORDENA, :MDROBO)';
  qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('EMASAI', VS_strCodEmp);
  qryTemp.ParamByName('CODIGO').AsString := strCodigo;
  qryTemp.ParamByName('CODGRU').AsString := strCodGru;
  qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryTemp.ParamByName('DESCRI').AsString := strDescri;
  qryTemp.ParamByName('PROENV').AsString := IIF(strCodGru = '009', 'F', 'O');
  qryTemp.ParamByName('STATUS').AsString := 'I';
  qryTemp.ParamByName('ORDENA').AsString := strCodigo;
  qryTemp.ParamByName('MDROBO').AsString := 'N';
  qryTemp.ExecSQL();
end;

procedure TfrmCfgEmailAviCob.pInicializarQuery;
begin
  qryTemp := fCriaQuery(nil);
  qryTemp.Close();
  qryTemp.SQL.Clear();
end;

procedure TfrmCfgEmailAviCob.ValidaSeTodosAtivosPossuemEmailConfigurado;
  Var
    LConsulta: TUniQuery;

    LExisteRegistroSemEmail: Boolean;
begin
  LExisteRegistroSemEmail := False;

  Try
    LConsulta := fCriaQuery;
    LConsulta.SQL.Text := 'SELECT AUTOINCREM FROM CFGEMA WHERE CFG_SEQGER=:SEQGER';

    cdsCfgEma.DisableControls;

    cdsCfgEma.Filter := 'STATUS=''A'' ';
    cdsCfgEma.Filtered := True;

    cdsCfgEma.First;

    While Not cdsCfgEma.Eof Do
    Begin
      LConsulta.Close;
      LConsulta.ParamByName('SEQGER').AsString := cdsCfgEma.FieldByName('AUTOIN').AsString;
      LConsulta.Open;

      LExisteRegistroSemEmail := LConsulta.IsEmpty;
      If LExisteRegistroSemEmail Then
        Break;

      cdsCfgEma.Next;
    End;
  Finally
    FreeAndNil(LConsulta);

    cdsCfgEma.Filter := '';
    cdsCfgEma.Filtered := False;

    cdsCfgEma.EnableControls;

    If LExisteRegistroSemEmail Then
      fMensagem('ATENÇÃO', 'Existe(m) modelo(s) ativo(s) sem os dados de envio configurados.' + #13 +
                           'Esse(s) modelo(s) não funcionará(ão) até que seja(m) configurado(s) os dados de envio.', ['&Ok']);
  End;
end;

end.
