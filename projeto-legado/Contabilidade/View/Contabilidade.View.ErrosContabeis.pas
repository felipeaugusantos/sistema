unit Contabilidade.View.ErrosContabeis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, UniClientDataSet, untExcel, untGeraExcel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxEditRepositoryItems, cxClasses, System.ImageList, Vcl.ImgList, cxImageList,
  cxGridLevel, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGridCustomView, cxGridCitel, cxGrid, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  cxDBLookupComboBox, Contabilidade.Interfaces, Uni, BitBtnLockedIncrem,
  dxBarBuiltInMenu, cxGridCustomPopupMenu, cxGridPopupMenu, dxNavBarCollns,
  dxNavBarBase, dxNavBar;

type
  TfrmErrosContabil = class(TForm)
    pnlBotoes: TPanel;
    btnGeraExcel: TSpeedButton;
    btnSair: TBitBtnLocked;
    imgImagens: TcxImageList;
    cxEditRepository1: TcxEditRepository;
    cmbStatusDesc: TcxEditRepositoryImageComboBoxItem;
    cmbStatusImg: TcxEditRepositoryImageComboBoxItem;
    dtsDados: TDataSource;
    btnDocOrigem: TSpeedButton;
    btnEfetuaCorrecao: TSpeedButton;
    dtsContas: TDataSource;
    dtsWarnings: TDataSource;
    cxGridPopupMenuER: TcxGridPopupMenu;
    cxGridPopupMenuWN: TcxGridPopupMenu;
    dxNavBar: TdxNavBar;
    NavBarGroupError: TdxNavBarGroup;
    NavBarGroupWarning: TdxNavBarGroup;
    NavBarItemErro: TdxNavBarItem;
    NavBarItemWarning: TdxNavBarItem;
    NavBarGroupErrorControl: TdxNavBarGroupControl;
    NavBarGroupWarningControl: TdxNavBarGroupControl;
    cxDados: TcxGridCitel;
    cxDadosDBTableView: TcxGridDBTableViewCitel;
    cxDadosDBTableViewSTATUS: TcxGridDBColumn;
    cxDadosDBTableViewCHVDOC: TcxGridDBColumn;
    cxDadosDBTableViewTIPLAN: TcxGridDBColumn;
    cxDadosDBTableViewORIGEM: TcxGridDBColumn;
    cxDadosDBTableViewMOTIVO: TcxGridDBColumn;
    cxDadosDBTableViewHISTOR: TcxGridDBColumn;
    cxDadosDBTableViewDESVAL: TcxGridDBColumn;
    cxDadosDBTableViewNATCFO: TcxGridDBColumn;
    cxDadosDBTableViewPLANCO: TcxGridDBColumn;
    cxDadosLevel1: TcxGridLevel;
    cxDadosWn: TcxGridCitel;
    cxDadosDBTableViewWn: TcxGridDBTableViewCitel;
    cxDadosDBTableViewWnSTATUS: TcxGridDBColumn;
    cxDadosDBTableViewWnCHVDOC: TcxGridDBColumn;
    cxDadosDBTableViewWnTIPLAN: TcxGridDBColumn;
    cxDadosDBTableViewWnORIGEM: TcxGridDBColumn;
    cxDadosDBTableViewWnMOTIVO: TcxGridDBColumn;
    cxDadosDBTableViewWnHISTOR: TcxGridDBColumn;
    cxDadosDBTableViewWnDESVAL: TcxGridDBColumn;
    cxDadosDBTableViewWnNATCFO: TcxGridDBColumn;
    cxDadosDBTableViewWnPLANCO: TcxGridDBColumn;
    cxDadosLevel1Wn: TcxGridLevel;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnGeraExcelClick(Sender: TObject);
    procedure btnDocOrigemClick(Sender: TObject);
    procedure btnEfetuaCorrecaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure cxDadosDBTableViewPLANCOPropertiesCloseUp(Sender: TObject);
    procedure cxDadosDBTableViewPLANCOPropertiesInitPopup(Sender: TObject);
    function fTrataConstanteTrDcZe(const AConst: string):string;
    function fRetornaCdsEscolhido: TUniClientDataSet ;
    function fRetornaGridEscolhida: TcxGridDBTableViewCitel ;
  private
    { Private declarations }
    qryContas : TUniQuery;
    FcdsWarnings: TUniClientDataSet;
    procedure OnGeraExcel(Excel: TExcel; Dados: TDataSet; Campos: TCampos; CorFundo: TCorExcel);
    procedure OnAfterScroll(DataSet: TDataSet);
    function fChaveCadRec(ANroChaveCRC: String) : String;
  public
    { Public declarations }
    cdsErros : TUniClientDataSet;
    objUpdateContaContabil : IUpdateContaContabil;
    // Nao assume a posse do ADataSet.
    class procedure pExibir(const ADataSet: TUniClientDataSet);
  end;

var
  frmErrosContabil: TfrmErrosContabil;

implementation

uses
  untFuncoesSimples, Contabilidade.Classes.TChamarDocOrigem,
  Contabilidade.Funcoes, System.MaskUtils;

{$R *.dfm}

procedure TfrmErrosContabil.btnDocOrigemClick(Sender: TObject);
  var
    strTabela : string;
    LChave    : string;
    LTipLan   : string;
    Lcds: TUniClientDataSet ;

begin
  strTabela := '';

  Lcds := fRetornaCdsEscolhido ;

  if Assigned(Lcds.FindField('ERR_TABELA')) then
    strTabela := Lcds.FieldByName('ERR_TABELA').AsString;

  if Assigned(Lcds.FindField('ERR_TIPLAN')) then
    LTipLan := Lcds.FieldByName('ERR_TIPLAN').AsString;

  if (strTabela = 'DUPAGR') and (LTipLan = 'CRC') then
    LChave := fChaveCadRec(Lcds.FieldByName('ERR_CHVDOC').AsString)
  else
    LChave := Lcds.FieldByName('ERR_CHVDOC').AsString;

  TChamarDocOrigem
    .New(Lcds.FieldByName('ERR_TIPLAN').AsString, LChave, strTabela)
    .Chamar;
end;

procedure TfrmErrosContabil.btnGeraExcelClick(Sender: TObject);
var
  LGridTab: TcxGridDBTableViewCitel ;
begin

  LGridTab := fRetornaGridEscolhida ;

  If TGeraExcel.fGerarRelatorio(LGridTab, 'Erros da Pré-Validação', OnGeraExcel) Then
    fMensagem('','Arquivo Salvo com Sucesso!', ['&OK']);
end;

class procedure TfrmErrosContabil.pExibir(const ADataSet: TUniClientDataSet);
var
  LfrmErrosContabil: TfrmErrosContabil;
begin
  pCriarFormularios(TfrmErrosContabil, LfrmErrosContabil);
  try
    LfrmErrosContabil.cdsErros := ADataSet;
    LfrmErrosContabil.ShowModal;
  finally
    pFreeAndNil(LfrmErrosContabil);
  end;
end;

procedure TfrmErrosContabil.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmErrosContabil.cxDadosDBTableViewPLANCOPropertiesCloseUp(
  Sender: TObject);
begin
  if cdsErros.State in [dsInsert, dsEdit] then
  begin
    if (cdsErros.FieldByName('ERR_ORIPLA').AsString = 'Abreviação') then
    begin
      cdsErros.Cancel;
      fMensagem('','Não é possível ajustar erros originados de parâmetros que definiram o destino do crédito e/ou débito como "Abreviação Contábil"!' + sLineBreak +
                   '*Abreviação contábil leva em conta outros fatores como CFOP para definir o crédito/débito.', ['&OK']);
    end
    else if (cdsErros.FieldByName('ERR_MOTIVO').AsString = CONTABIL_MSG_NAO_DEFINIU_DEBITO_NEM_CREDITO) then
    begin
      cdsErros.Cancel;
      fMensagem('','Não é possível ajustar erros de parâmetros que não definiram nenhum tipo de conta, nem crédito, nem débito!', ['&OK']);
    end
    else if (fTrataConstanteTrDcZe(cdsErros.FieldByName('ERR_MOTIVO').AsString) = CONTABIL_MSG_TOTDEB_MENOS_TOTCRE_DIFERENTE_ZERO) then
    begin
      cdsErros.Cancel;
      fMensagem('','Não é possível ajustar erros causado por diferença de valores!', ['&OK']);
    end
    else
      cdsErros.Post;
  end;
end;

procedure TfrmErrosContabil.cxDadosDBTableViewPLANCOPropertiesInitPopup(
  Sender: TObject);
begin
  qryContas.FieldByName('Conta').EditMask := fMskCon;
end;

procedure TfrmErrosContabil.FormCreate(Sender: TObject);
begin
  cdsErros := Nil ;
  qryContas := fCriaQuery(Self);

  qryContas.SQL.Text := 'SELECT DISTINCT NCO_CODCON AS "Conta" FROM PLANCO ORDER BY NCO_CODCON';
  qryContas.Open;
  qryContas.FieldByName('Conta').EditMask := fMskCon;

  dtsContas.DataSet := qryContas;
  Self.WindowState := wsMaximized;

  FcdsWarnings := TUniClientDataSet.Create(Nil) ;
end;

procedure TfrmErrosContabil.FormDestroy(Sender: TObject);
begin
  qryContas.Close;

  if Assigned(cdsErros) then
  begin
    cdsErros.Filtered := False ;
    // O dataset e de quem chamou e continua em uso depois da tela (Req. 470760): o evento nao pode
    // ficar apontando para esta tela ja destruida.
    cdsErros.AfterScroll := nil ;
  end;

  FreeAndNil(qryContas);

  FreeAndNil(FcdsWarnings);
end;

procedure TfrmErrosContabil.FormShow(Sender: TObject);
var
  LintCntWarning: Integer ;
begin
  cdsErros.DisableControls ;
  try
    pCloneDataSet(FcdsWarnings, cdsErros);

    cdsErros.Filtered := False ;
    cdsErros.Filter := 'ERR_STATUS = ' + QuotedStr('EE') ;
    cdsErros.Filtered := True ;
    dtsDados.DataSet := cdsErros;

    FcdsWarnings.Filtered := False ;
    FcdsWarnings.Filter := 'ERR_STATUS <> ' + QuotedStr('EE') ;
    FcdsWarnings.Filtered := True ;
    dtsWarnings.DataSet := FcdsWarnings;

    LintCntWarning := FcdsWarnings.RecordCount ;

    if LintCntWarning = 0 then
      NavBarGroupWarning.Visible := False ;

    if cdsErros.RecordCount = 0 then
    begin
      NavBarGroupError.OptionsExpansion.Expanded := False ;
      NavBarGroupWarning.OptionsExpansion.Expanded := True ;
    end ;

    NavBarGroupError.Caption := 'Erros (' + cdsErros.RecordCount.ToString + ')' ;
    NavBarGroupWarning.Caption := 'Advertências (' + LintCntWarning.ToString + ')' ;

  finally
    cdsErros.EnableControls ;
  end ;

  cxDadosDBTableView.ViewData.Expand(True);
  cxDadosDBTableView.DataController.GotoFirst;

  cxDadosDBTableViewWn.ViewData.Expand(True);
  cxDadosDBTableViewWn.DataController.GotoFirst;

  if not FcdsWarnings.IsEmpty then
  begin
    FcdsWarnings.AfterScroll := OnAfterScroll;
    OnAfterScroll(FcdsWarnings);
  end ;

  cdsErros.AfterScroll := OnAfterScroll;
  OnAfterScroll(cdsErros);

  Self.Caption := 'Inconsistências (' + IntToStr(cdsErros.RecordCount + LintCntWarning) + ')';
end;

function TfrmErrosContabil.fRetornaCdsEscolhido: TUniClientDataSet;
const
  TAMANHO_BOTOES_MSG : Integer = 200 ;
var
  LintOpcao: Integer ;
begin
  Result := cdsErros ;

  if FcdsWarnings.IsEmpty then
    Exit ;

  if (cdsErros.IsEmpty) and (not FcdsWarnings.IsEmpty) then
  begin
    Result := FcdsWarnings ;
    Exit ;
  end ;

  LintOpcao := fMensagem('ATENÇÃO!', 'Escolha uma opção!', ['&Origem do Erro', '&Origem da Advertência'], 2, False, 1, TAMANHO_BOTOES_MSG);

  if LintOpcao = 1 then
    Exit ;

  Result := FcdsWarnings ;
end;

function TfrmErrosContabil.fRetornaGridEscolhida: TcxGridDBTableViewCitel;
const
  TAMANHO_BOTOES_MSG : Integer = 200 ;
var
  LintOpcao: Integer ;
begin
  Result := cxDadosDBTableView ;

  if FcdsWarnings.IsEmpty then
    Exit ;

  if (cdsErros.IsEmpty) and (not FcdsWarnings.IsEmpty) then
  begin
    Result := cxDadosDBTableViewWn ;
    Exit ;
  end ;

  LintOpcao := fMensagem('ATENÇÃO!', 'Escolha uma opção!', ['&Origem do Erro', '&Origem da Advertência'], 2, False, 1, TAMANHO_BOTOES_MSG);

  if LintOpcao = 1 then
    Exit ;

  Result := cxDadosDBTableViewWn ;
end;

function TfrmErrosContabil.fTrataConstanteTrDcZe(const AConst: string): string;
var
  intCnt: integer ;
  strRetorno: string ;
  blnFlag: boolean ;
begin
  strRetorno := '' ;
  blnFlag := False ;
  for intCnt := 1 to Length(AConst) do
  begin
    if (AConst[intCnt] <> '[') and (not blnFlag) then
    begin
      strRetorno := strRetorno + AConst[intCnt] ;
    end
    else
    begin
      blnFlag := True ;
      if AConst[intCnt] = ']'  then
      begin
        strRetorno := strRetorno + '[%s]' ;
        blnFlag := False ;
      end;
    end;
  end;
  result := strRetorno ;
end;

procedure TfrmErrosContabil.OnAfterScroll(DataSet: TDataSet);
begin
  btnDocOrigem.Visible := (not DataSet.FieldByName('ERR_CHVDOC').AsString.IsEmpty) and (not DataSet.FieldByName('ERR_TIPLAN').AsString.IsEmpty);
  if (not fSemMascaraPlaNco(cdsErros.FieldByName('ERR_PLANCO').AsString).IsEmpty) then
    btnEfetuaCorrecao.Visible := True;
end;

procedure TfrmErrosContabil.OnGeraExcel(Excel: TExcel; Dados: TDataSet;
  Campos: TCampos; CorFundo: TCorExcel);
begin
//
end;

function TfrmErrosContabil.fChaveCadRec(ANroChaveCRC: String) : String;
var LQryChave: TUniQuery;
begin
  LQryChave := fCriaQuery(Self);
  try
    LQryChave.SQL.Clear;
    LQryChave.SQL.Add('SELECT C.AUTOINCREM ');
    LQryChave.SQL.Add('FROM DUPAGR D ');
    LQryChave.SQL.Add('LEFT JOIN CADREC C ON (D.CTR_NUMAGR = C.CTR_NUMDUP AND D.CTR_EMPAGR = C.CTR_CODEMP AND D.CTR_CODCLI = C.CTR_CODCLI AND C.CTR_ESPDOC = :ESPDOC AND C.CTR_SEQBAI = 0)');
    LQryChave.SQL.Add('WHERE D.AUTOINCREM = :CHAVE ');
    LQryChave.SQL.Add('LIMIT 1');
    LQryChave.ParamByName('ESPDOC').AsString := 'AG';
    LQryChave.ParamByName('CHAVE').AsString  := ANroChaveCRC;
    LQryChave.Open;
    if (not (LQryChave.IsEmpty)) and (not LQryChave.FieldByName('AUTOINCREM').IsNull) then
      Result := LQryChave.FieldByName('AUTOINCREM').AsString
    else
      Result := '';
    LQryChave.Close;
  finally
    FreeAndNil(LQryChave);
  end;
end;

procedure TfrmErrosContabil.btnEfetuaCorrecaoClick(Sender: TObject);
begin
  if not Assigned(cdsErros) then
    exit;

  if not cdsErros.Active then
    Exit;

  if cdsErros.IsEmpty then
    Exit;

  if not Assigned(objUpdateContaContabil) then
    exit;

  btnEfetuaCorrecao.Enabled := False;
  try
    cdsErros.DisableControls;
    cdsErros.First;
    while not cdsErros.Eof do
    begin
      if not fSemMascaraPlaNco(cdsErros.FieldByName('ERR_PLANCO').AsString).IsEmpty then
      begin
        objUpdateContaContabil.setContaContabil(fSemMascaraPlaNco(cdsErros.FieldByName('ERR_PLANCO').AsString), cdsErros.FieldByName('ERR_CHVDOC').AsString);
        cdsErros.Delete;
        Continue;
      end;
      cdsErros.Next;
    end;

    fMensagem('','Contas atualizadas!', ['&OK']);
    Self.Caption := 'Inconsistências (' + cdsErros.RecordCount.ToString + ')';
    btnEfetuaCorrecao.Visible := False;
    btnEfetuaCorrecao.Enabled := True;
  finally
    cdsErros.EnableControls;
  end;
end;

end.
