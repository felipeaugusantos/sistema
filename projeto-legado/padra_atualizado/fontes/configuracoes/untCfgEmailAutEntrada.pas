unit untCfgEmailAutEntrada;

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
  cxDataControllerConditionalFormattingRulesManagerDialog, cxSpinEdit,untTypesSistema ;

type
  TfrmCfgEmailAutEntrada = class(TfrmPaiConfirma)
    Panel1: TPanel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitelTableView: TcxGridDBTableViewCitel;
    cxGridCitel1: TcxGridCitel;
    ATIVO: TcxGridDBColumn;
    DESCRIÇÃO: TcxGridDBColumn;
    EDITOR: TcxGridDBColumn;
    ENVIO: TcxGridDBColumn;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    GRUPO: TcxGridDBColumn;
    dtsEmaEnt: TDataSource;
    DIAS: TcxGridDBColumn;
    procedure EDITORPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnConfirmaClick(Sender: TObject);
    procedure ENVIOPropertiesChange(Sender: TObject);
  private
    qryCfgEma: TUniQuery;
    cdsCfgEma: TUniClientDataSet;
    dspCfgEma: TUniDataSetProvider;
    procedure pCarregaConfiguracoes;
    procedure pGravar;
    function fRetEspecieDocumento(strCodGru: String): String;
    procedure pCriarConfiguracoesPadrao;
  public
    procCfgDisparaEmailPedidoDeCompraAutomatico: TCfgDisparaEmailPedidoDeCompraAutomatico;
    { Public declarations }
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples, untCfgModeloEmail, untCfgEmailAutenticacao,
  untDisparaEmailAutEnt;

procedure TfrmCfgEmailAutEntrada.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravar;
end;

procedure TfrmCfgEmailAutEntrada.EDITORPropertiesButtonClick(Sender: TObject;
  AButtonIndex: Integer);
begin
  inherited;

  pCriarFormularios(TfrmCfgModeloEmail, frmCfgModeloEmail);
  frmCfgModeloEmail.Caption   := frmCfgModeloEmail.Caption + ' - ' + dtsEmaEnt.DataSet.FieldByName('DESCRI').AsString;
  frmCfgModeloEmail.strSeqGer := dtsEmaEnt.DataSet.FieldByName('AUTOIN').AsString;
  frmCfgModeloEmail.strEspDoc := fRetEspecieDocumento(dtsEmaEnt.DataSet.FieldByName('CODGRU').AsString);
  frmCfgModeloEmail.strEntSai := 'E';
  If dtsEmaEnt.DataSet.FieldByName('CODGRU').AsString = egPedidoCompra.fGetCode() then
  Begin
    frmCfgModeloEmail.btnConfiguraEmailPedidoCompraPDF.Visible := True;
    frmCfgModeloEmail.CfgDisparaEmailPedidoDeCompraAutomatico := procCfgDisparaEmailPedidoDeCompraAutomatico;

    If dtsEmaEnt.DataSet.FieldByName('EMA_CODIGO').AsString = opcIncluscaoEmail.fGetCode() Then
      frmCfgModeloEmail.optCodigo := opcIncluscaoEmail.fGetCode()
  End;

  //TOptPedidoCompra.fGetChavePdf

  frmCfgModeloEmail.ShowModal();
  pFreeAndNil(frmCfgModeloEmail);
end;

procedure TfrmCfgEmailAutEntrada.ENVIOPropertiesChange(Sender: TObject);
begin
  inherited;

  If (dtsEmaEnt.DataSet.State = dsEdit) Then
    dtsEmaEnt.DataSet.Post;

  If dtsEmaEnt.DataSet.Fieldbyname('PROENV').AsString = 'F' Then
  Begin
    Try
      pCriarFormularios(TfrmCfgEmailAutenticacao, frmCfgEmailAutenticacao);
      frmCfgEmailAutenticacao.strSeqGer := dtsEmaEnt.DataSet.FieldByName('AUTOIN').AsString;
      frmCfgEmailAutenticacao.ShowModal();
    Except
      On E: Exception Do
        pMensagensErro(e.Message, '[TfrmCfgEmailAutEntrada.ENVIOPropertiesChange]');
    End;

    pFreeAndNil(frmCfgEmailAutenticacao);

  End;
end;

procedure TfrmCfgEmailAutEntrada.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  FreeAndNil(qryCfgEma);
  FreeAndNil(dspCfgEma);
  FreeAndNil(cdsCfgEma);
end;

procedure TfrmCfgEmailAutEntrada.FormShow(Sender: TObject);
begin
  inherited;
  qryCfgEma := fCriaQuery(Self);
  dspCfgEma := TUniDataSetProvider.Create(Self);
  cdsCfgEma := TUniClientDataSet.Create(Self);

  dspCfgEma.DataSet := qryCfgEma;
  cdsCfgEma.SetProvider(dspCfgEma);

  dtsEmaEnt.DataSet := cdsCfgEma;
  pCarregaConfiguracoes;
  cxGridCitelTableView.ViewData.Expand(True);
end;

function TfrmCfgEmailAutEntrada.fRetEspecieDocumento(strCodGru: String): String;
begin
  Result := '';

  If (strCodGru = '001') Or (strCodGru = '002') Then
    Result := 'PD';
end;

procedure TfrmCfgEmailAutEntrada.pCarregaConfiguracoes;
Var
  strSQL: String;
begin
  pCriarConfiguracoesPadrao();

  Try

    strSQL := '';
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(GRU_CODGRU, "-", GRU_DESGRU) AS GRUPOS, ';
    strSQL := strSQL + '  EMA_CODIGO, ';
    strSQL := strSQL + '  GRU_CODGRU        AS CODGRU, ';
    strSQL := strSQL + '  EMA_CODEMP        AS CODEMP, ';
    strSQL := strSQL + '  EMA_STATUS        AS STATUS, ';
    strSQL := strSQL + '  EMA_DESCRI        AS DESCRI, ';
    strSQL := strSQL + '  EMA_PROENV        AS PROENV, ';
    strSQL := strSQL + '  EMA_ORDENA        AS ORDENA, ';
    strSQL := strSQL + '  EMA_QTDIAS        AS QTDIAS,   ';
    strSQL := strSQL + '  EMASAI.AUTOINCREM AS AUTOIN  ';
    strSQL := strSQL + 'FROM      ';
    strSQL := strSQL + '  EMASAI  ';
    strSQL := strSQL + '  INNER JOIN GRUEMA ON GRU_ENTSAI = EMA_ENTSAI ';
    strSQL := strSQL + '         AND GRU_CODGRU = EMA_CODGRU ';
    strSQL := strSQL + 'WHERE     ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP AND ';
    strSQL := strSQL + '  EMA_ENTSAI = :ENTSAI ';
    strSQL := strSQL + 'ORDER BY  ';
    strSQL := strSQL + '  CODGRU, ';
    strSQL := strSQL + '  ORDENA  ';

    With qryCfgEma Do
    Begin
      Close;
      SQL.Clear;
      SQL.Add(strSQL);
      ParamByName('CODEMP').AsString := VS_strCodEmp;
      ParamByName('ENTSAI').AsString := 'E';
      Open;
      pSetaClient(qryCfgEma);
      cdsCfgEma.Open;
      pSetaClient(cdsCfgEma);
    End;

  Except
    On E:Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAutEntrada.pCarregaConfiguracoes]');
  End;

end;

procedure TfrmCfgEmailAutEntrada.pCriarConfiguracoesPadrao;
  Var
    egItem: TEntryGroup;
    ofuItem: TOptFollowUp;
    opcItem: TOptPedidoCompra;
    qryTemp: TUniQuery;

  procedure pInicializarQuery; begin
    qryTemp := fCriaQuery(nil);
    qryTemp.Close();
    qryTemp.SQL.Clear();
  end;

  function fExisteGruEma(strCodGru: String): Boolean; begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'GRUEMA',
                                            ['GRU_ENTSAI', 'GRU_CODGRU'],
                                            ['E', strCodGru]) ) );
  end;

  procedure pIncluirRegistroGruEma(strCodGru, strDesGru: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO GRUEMA (AUTOINCREM, GRU_CODGRU, GRU_CODEMP, GRU_DESGRU, GRU_ENTSAI) ' +
      ' VALUES (:AUTINC, :CODGRU, :CODEMP, :DESGRU, :ENTSAI)';
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('GRUEMA', VS_strCodEmp);
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESGRU').AsString := strDesGru;
    qryTemp.ParamByName('ENTSAI').AsString := 'E';
    qryTemp.ExecSQL();
  end;

  function fExisteEmaSai(strCodGru, strCodigo: String): Boolean; begin
    Result := ( Not fEmptyStr( fCampoTabela('AUTOINCREM',
                                            'EMASAI',
                                            ['EMA_CODIGO', 'EMA_ENTSAI', 'EMA_CODGRU', 'EMA_CODEMP'],
                                            [strCodigo, 'E', strCodGru, VS_strCodEmp]) ) );
  end;

  procedure pIncluirRegistroEmaSai(strCodigo, strCodGru, strDescri: String); begin
    qryTemp.Close();
    qryTemp.SQL.Clear();
    qryTemp.SQL.Text := 'INSERT INTO EMASAI (AUTOINCREM, EMA_CODIGO, EMA_CODGRU, EMA_CODEMP, EMA_DESCRI, ' +
      'EMA_PROENV, EMA_STATUS, EMA_ORDENA, EMA_ENTSAI) VALUES (:AUTINC, :CODIGO, :CODGRU, :CODEMP, :DESCRI, ' +
      ':PROENV, :STATUS, :ORDENA, :ENTSAI)';
    qryTemp.ParamByName('AUTINC').AsString := fRetAutoIncrem('EMASAI', VS_strCodEmp);
    qryTemp.ParamByName('CODIGO').AsString := strCodigo;
    qryTemp.ParamByName('CODGRU').AsString := strCodGru;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.ParamByName('DESCRI').AsString := strDescri;
    qryTemp.ParamByName('PROENV').AsString := 'O';
    qryTemp.ParamByName('STATUS').AsString := 'I';
    qryTemp.ParamByName('ORDENA').AsString := strCodigo;
    qryTemp.ParamByName('ENTSAI').AsString := 'E';
    qryTemp.ExecSQL();
  end;

begin
  Try
    pInicializarQuery();

    Try
      fStartTransaction();

      For egItem := Low(TEntryGroup) To High(TEntryGroup) Do
      Begin
        If (Not fExisteGruEma(egItem.fGetCode()))  Then
          pIncluirRegistroGruEma(egItem.fGetCode(), egItem.fGetDescription());

        Case egItem Of
          egFollowUp:
            Begin
              For ofuItem := Low(TOptFollowUp) To High(TOptFollowUp) Do
              Begin
                If (Not fExisteEmaSai(egItem.fGetCode(), ofuItem.fGetCode())) Then
                  pIncluirRegistroEmaSai(ofuItem.fGetCode(), egItem.fGetCode(), ofuItem.fGetDescription());
              End;
            End;
          egPedidoCompra:
            Begin
              For opcItem := Low(TOptPedidoCompra) To High(TOptPedidoCompra) Do
              Begin
                If (Not fExisteEmaSai(egItem.fGetCode(), opcItem.fGetCode())) Then
                  pIncluirRegistroEmaSai(opcItem.fGetCode(), egItem.fGetCode(), opcItem.fGetDescription());
              End;
            End;

        End;
      End;

	    fCommit();
    Except
      On E: Exception Do Begin
        fRollBack();
        pMensagensErro(e.Message, '[TfrmCfgEmailAutEntrada.pCriarConfiguracoesPadrao]')
      End;
    End;
  Finally
    FreeAndNil(qryTemp);
  End;
end;

procedure TfrmCfgEmailAutEntrada.pGravar;
Var
  qryGravar: TUniQuery;
  strSQL   : String;
begin

  Try

    qryGravar := fCriaQuery(Self);

    strSQL := '';
    strSQL := strSQL + 'UPDATE           ';
    strSQL := strSQL + '  EMASAI         ';
    strSQL := strSQL + 'SET              ';
    strSQL := strSQL + '  EMA_STATUS = :STATUS,    ';
    strSQL := strSQL + '  EMA_PROENV = :PROENV,    ';
    strSQL := strSQL + '  EMA_QTDIAS = :QTDIAS     ';
    strSQL := strSQL + 'WHERE            ';
    strSQL := strSQL + '  AUTOINCREM = :AUTOIN AND ';
    strSQL := strSQL + '  EMA_CODEMP = :CODEMP     ';

    With qryGravar Do
    Begin
      cdsCfgEma.First;

      While Not cdsCfgEma.Eof Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(strSQL);
        ParamByName('STATUS').AsString := cdsCfgEma.FieldByName('STATUS').AsString;
        ParamByName('PROENV').AsString := cdsCfgEma.FieldByName('PROENV').AsString;
        ParamByName('QTDIAS').AsInteger:= cdsCfgEma.FieldByName('QTDIAS').AsInteger;
        ParamByName('AUTOIN').AsString := cdsCfgEma.FieldByName('AUTOIN').AsString;
        ParamByName('CODEMP').AsString := cdsCfgEma.FieldByName('CODEMP').AsString;
        ExecSQL;
        cdsCfgEma.Next;
      End;
    End;

  Except
    On E: Exception Do
      pMensagensErro(e.Message, '[TfrmCfgEmailAutEntrada.pGravar]')
  End;

  FreeAndNil(qryGravar);

end;

end.
