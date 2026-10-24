unit Faturamento.Consignacao.DefinicaoItensRetorno;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiSimples, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, untFuncoesSimples,
  cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles,
  cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGridLevel,
  cxClasses, cxGridCustomView, cxGridCitel, cxGrid, Vcl.Grids, Vcl.DBGrids,
  DBGridCitel, UniClientDataSet, Faturamento.Consignacao.Classes,
  Datasnap.DBClient, Datasnap.Provider, cxCurrencyEdit;

type
  TfrmFaturamentoConsignacaoDefinicaoItensRetorno = class(TfrmPaiSimples)
    Panel1: TPanel;
    dtsItens: TDataSource;
    btnConfirma: TBitBtnLocked;
    Panel3: TPanel;
    Label2: TLabel;
    cxGridCitel2: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBColumn1: TcxGridDBColumn;
    cxGridDBColumn2: TcxGridDBColumn;
    cxGridDBColumn3: TcxGridDBColumn;
    cxGridDBColumn4: TcxGridDBColumn;
    cxGridDBColumn5: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dtsItensDocumentoEnvio: TDataSource;
    Panel2: TPanel;
    cxGridCitel1: TcxGridCitel;
    grdItens: TcxGridDBTableViewCitel;
    grdItensColumn1: TcxGridDBColumn;
    grdItensColumn2: TcxGridDBColumn;
    grdItensColumn4: TcxGridDBColumn;
    grdItensColumn3: TcxGridDBColumn;
    grdItensColumn5: TcxGridDBColumn;
    grdItensColumn7: TcxGridDBColumn;
    grdItensColumn6: TcxGridDBColumn;
    cxGridCitel1Level1: TcxGridLevel;
    ClientDataSet1: TClientDataSet;
    btnConfirmar: TBitBtnLocked;
    BitBtnLocked1: TBitBtnLocked;
    Label1: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure grdItensEditKeyPress(Sender: TcxCustomGridTableView;
      AItem: TcxCustomGridTableItem; AEdit: TcxCustomEdit; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure grdItensColumn7CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
    procedure grdItensColumn6CustomDrawCell(Sender: TcxCustomGridTableView;
      ACanvas: TcxCanvas; AViewInfo: TcxGridTableDataCellViewInfo;
      var ADone: Boolean);
  private
    { Private declarations }
    FQueryNotaGerada                : TUniQuery;
    FQueryNotaEnvio                 : TUniQuery;
    FQueryNotaEnvioParaValidacao    : TUniQuery;
    FCdsItensDoEnvio                : TUniClientDataSet;
    FCdsItensParaValidacao          :  TUniClientDataSet;
    FCdsItensParaValidacaoAnalitico :  TUniClientDataSet;
    FTipoRetornoConsignacao         : tTipoRetornoConsignacao;
    FblnValidado                    : Boolean;

    procedure pCriarDataSets;
    procedure pAlimentarCdsAnaliticoItensParaValidacao;
    procedure pAlimentarCdsItensParaValidacao;
    function fValidarSaldos(var Amensagem : String) : Boolean;

  public
    { Public declarations }
    function fValidarInformacoesNaNotaDeRetorno(var AMensagem : String) : Boolean;

    property QueryNotaGerada              : TUniQuery                read FQueryNotaGerada             write FQueryNotaGerada;
    property QueryNotaEnvio               : TUniQuery                read FQueryNotaEnvio              write FQueryNotaEnvio;
    property QueryNotaEnvioParaValidacao  : TUniquery                read FQueryNotaEnvioParaValidacao write FQueryNotaEnvioParaValidacao;
    property CdsItensDoEnvio              : TUniClientDataSet        read FCdsItensDoEnvio             write FCdsItensDoEnvio;
    property TipoRetornoConsignacao       : tTipoRetornoConsignacao  read FTipoRetornoConsignacao      write FTipoRetornoConsignacao;
    property blnValidado                  : Boolean                  read FblnValidado                 write FblnValidado;
  end;

implementation

uses untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.btnConfirmarClick(Sender: TObject);
  var
    LQueryValorUnitario : TUniQuery;
    LstrMensagem        : string;
begin
  LQueryValorUnitario := fCriaQuery;

  Try
    LQueryValorUnitario.Sql.Text := 'SELECT MOVDET.DET_UNITAR '+
                                    '  FROM MOVDET '+
                                    ' WHERE MOVDET.DET_SEQGER IN (SELECT MOVDET.DET_SEQGER '+
                                    '                               FROM MOVDET '+
                                    '                              WHERE MOVDET.AUTOINCREM = :AUTINC) '+
                                    '   AND MOVDET.DET_CODITE = :CODITE '+
                                    '   AND MOVDET.DET_UNITAR = :UNITAR '+
                                    '   AND MOVDET.DET_UNIDAD = :UNIDAD ';

    FCdsItensDoEnvio.First;
    while not FCdsItensDoEnvio.Eof do
    Begin
      LQueryValorUnitario.ParamByName('AUTINC').AsString := FCdsItensDoEnvio.FieldByName('ID_NOTA_EN').AsString;
      LQueryValorUnitario.ParamByName('CODITE').AsString := FCdsItensDoEnvio.FieldByName('ITE_CODITE').AsString;
      LQueryValorUnitario.ParamByName('UNITAR').AsFloat  := FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat;
      LQueryValorUnitario.ParamByName('UNIDAD').AsString := FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString;
      LQueryValorUnitario.Open;
      if LQueryValorUnitario.IsEmpty then
      Begin
        fMensagem('Atenção!', 'valor unitário de "R$'+FloatToStr(FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat)+'" com '+
        'unidade de medida "'+FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString+'", informada ao '+
        'produto "'+FCdsItensDoEnvio.FieldByName('ITE_DESITE').AsString+'", '+
        'não existe nos documentos de envio. Favor revisar.', ['&Ok']);

        FblnValidado := False;
        Exit;
      End;
      LQueryValorUnitario.Close;

      FCdsItensDoEnvio.next;
    End;

    if not fValidarSaldos(LstrMensagem) then
    Begin
      fMensagem('Atenção!', LstrMensagem, ['&Ok']);
      FblnValidado := False;
      Exit;
    End;

    FblnValidado := True;

    Self.Close;
  Finally
    freeAndNil(LQueryValorUnitario);
  End;

end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.btnSairClick(Sender: TObject);
begin
  inherited;
  FblnValidado := False;
  Self.Close;
end;

function TfrmFaturamentoConsignacaoDefinicaoItensRetorno.fValidarInformacoesNaNotaDeRetorno(var AMensagem : String): Boolean;
  var
    LstrMensagem : String;
begin
  Result := True;

  LstrMensagem := 'Valores unitários\unidades informadas no documento de retorno de consignação diferem do '+
                   'documento de envio de consigação. Será necessário revisar. ';

  pCriarDataSets;
  dtsItens.dataset               := FCdsItensDoEnvio;
  dtsItensDocumentoEnvio.dataSet := FCdsItensParaValidacao;

  FCdsItensDoEnvio.First;
  while not FCdsItensDoEnvio.Eof do
  Begin
    if FCdsItensDoEnvio.FieldByName('ITE_UNIRET').AsFloat <> FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat then
    Begin
      AMensagem := LstrMensagem;
      Exit(False);
    End;

    if FCdsItensDoEnvio.FieldByName('ITE_UNDRET').AsString <> FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString then
    Begin
      AMensagem := LstrMensagem;
      Exit(False);
    End;

    FCdsItensDoEnvio.Next;
  End;

  if not fValidarSaldos(AMensagem) then
    Exit(False);

  FblnValidado := True;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.FormCreate(Sender: TObject);
begin
  inherited;
  FQueryNotaGerada             := fCriaQuery;
  FQueryNotaEnvio              := fCriaQuery;
  FQueryNotaEnvioParaValidacao := fCriaQuery;
  FblnValidado                 := False;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FQueryNotaEnvio);
  FreeAndNil(FQueryNotaEnvioParaValidacao);
  FreeAndNil(FCdsItensParaValidacao);
  FreeAndNil(FCdsItensParaValidacaoAnalitico);
  inherited;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.FormShow(
  Sender: TObject);
begin
  inherited;

  FCdsItensDoEnvio.First;
  while not FCdsItensDoEnvio.Eof do
  begin
    FCdsItensDoEnvio.Edit;
    FCdsItensDoEnvio.FieldByname('ITE_UNDENV').AsString := '';
    FCdsItensDoEnvio.FieldByname('ITE_UNITAR').AsFloat  := 0.00;
    FCdsItensDoEnvio.Post;

    FCdsItensDoEnvio.next;
  end;
end;

function TfrmFaturamentoConsignacaoDefinicaoItensRetorno.fValidarSaldos(var Amensagem : String) : Boolean;
  var
    LIntPosicao        : Integer;
    LstrChave          : String;
    LfltQuantidadeAcumulada : Double;
begin
  Result := True;

  FCdsItensDoEnvio.First;
  while not FCdsItensDoEnvio.Eof do
  Begin
    LIntPosicao        := FCdsItensDoEnvio.RecNo;
    LstrChave          := FCdsItensDoEnvio.FieldByName('ITE_CODITE').AsString +
                          UpperCase(FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString) +
                          FloatToStr(FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat);
    LfltQuantidadeAcumulada := FCdsItensDoEnvio.FieldByName('ITE_QTDITE').AsFloat;

    FCdsItensDoEnvio.First;
    while not FCdsItensDoEnvio.Eof do
    begin
      If (LIntPosicao <> FCdsItensDoEnvio.RecNo) then
        if LstrChave = FCdsItensDoEnvio.FieldByName('ITE_CODITE').AsString +
                       UpperCase(FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString) +
                       FloatToStr(FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat) then
          LfltQuantidadeAcumulada := LfltQuantidadeAcumulada + FCdsItensDoEnvio.FieldByName('ITE_QTDITE').AsFloat;

      FCdsItensDoEnvio.next;
    end;

    FCdsItensDoEnvio.RecNo := LIntPosicao;

    if (FCdsItensParaValidacao.Locate('ITE_CODITE;ITE_UNIDAD;ITE_UNITAR',
      VarArrayOf([FCdsItensDoEnvio.FieldByName('ITE_CODITE').AsString,
                  UpperCase(FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString),
                  FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat]), [])) then
    Begin
      if LfltQuantidadeAcumulada > FCdsItensParaValidacao.FieldByname('ITE_SALDO_').AsFloat then
      Begin
        Amensagem := 'Quantidade retornada ("'+FloatToStr(LfltQuantidadeAcumulada)+'") para a consignação do produto "'+FCdsItensDoEnvio.FieldByName('ITE_DESITE').AsString+'", '+
        'com unidade de medida "'+FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString+'" e valor unitário "R$'+
        FloatToStr(FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat)+'" excede o saldo existente ("'+FloatToStr(FCdsItensParaValidacao.FieldByname('ITE_SALDO_').AsFloat)+'"), '+
        'favor revisar.';
        Exit(False);
      End;
    End;

    FCdsItensDoEnvio.next;
  End;

end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.grdItensColumn6CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not AViewInfo.Selected Then
    ACanvas.Brush.Color := clLime;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.grdItensColumn7CustomDrawCell(Sender: TcxCustomGridTableView; ACanvas: TcxCanvas;
  AViewInfo: TcxGridTableDataCellViewInfo; var ADone: Boolean);
begin
  inherited;
  If Not AViewInfo.Selected Then
    ACanvas.Brush.Color := clLime;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.grdItensEditKeyPress(Sender: TcxCustomGridTableView; AItem: TcxCustomGridTableItem;
  AEdit: TcxCustomEdit; var Key: Char);
  Var
    LQuery      : TUniQuery;
    LarrUnidade : TConsultasArray;
begin
  inherited;

  If (AItem as TcxGridDBColumn).DataBinding.FieldName <> 'ITE_UNDENV' then
    Exit;

  If fEntraCons(Key) Then
  Begin

    LQuery := fCriaQuery(Self);

    if fPesqUnidade(Self, Nil, Nil, Nil, LQuery, Key, LarrUnidade) then
    Begin
      AItem.EditValue := LQuery.FieldByName('UNI_CODUNI').AsString;
    End;

    FreeAndNil(LQuery);
  End;

end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.pAlimentarCdsAnaliticoItensParaValidacao;
begin
  FQueryNotaEnvio.First;
  while not FQueryNotaEnvio.Eof do
  Begin
    if not(FCdsItensParaValidacaoAnalitico.Locate('AUTOINCREM', FQueryNotaEnvio.FieldByName('AUTOINCREM').AsString, [])) then
    Begin
      FCdsItensParaValidacaoAnalitico.Append;
      FCdsItensParaValidacaoAnalitico.FieldByName('AUTOINCREM').AsString := FQueryNotaEnvio.FieldByName('AUTOINCREM').AsString;
      FCdsItensParaValidacaoAnalitico.FieldByName('ITE_CODITE').AsString := FQueryNotaGerada.FieldByName('DET_CODITE').AsString;
      FCdsItensParaValidacaoAnalitico.FieldByName('ITE_DESITE').AsString := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'],
                                                                            [FQueryNotaGerada.FieldByName('DET_CODITE').AsString]);
      FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNIDAD').AsString := UpperCase(FQueryNotaEnvio.FieldByName('DET_UNIDAD').AsString);
      FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNITAR').AsFloat  := FQueryNotaEnvio.FieldByName('DET_UNITAR').AsFloat;
      FCdsItensParaValidacaoAnalitico.FieldByName('ITE_SALDO_').AsFloat  := FQueryNotaEnvio.FieldByName('DET_SALDO_').AsFloat;
      FCdsItensParaValidacaoAnalitico.Post;
    End;

    FQueryNotaEnvio.Next;
  End;
end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.pAlimentarCdsItensParaValidacao;
begin
  FCdsItensParaValidacaoAnalitico.First;
  while not FCdsItensParaValidacaoAnalitico.Eof do
  Begin
    if not(FCdsItensParaValidacao.Locate('ITE_CODITE;ITE_UNIDAD;ITE_UNITAR',
      VarArrayOf([FCdsItensParaValidacaoAnalitico.FieldByName('ITE_CODITE').AsString,
                  FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNIDAD').AsString,
                  FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNITAR').AsFloat]), [])) then
    Begin
      FCdsItensParaValidacao.Append;
      FCdsItensParaValidacao.FieldByName('ITE_CODITE').AsString := FCdsItensParaValidacaoAnalitico.FieldByName('ITE_CODITE').AsString;
      FCdsItensParaValidacao.FieldByName('ITE_DESITE').AsString := FCdsItensParaValidacaoAnalitico.FieldByName('ITE_DESITE').AsString;
      FCdsItensParaValidacao.FieldByName('ITE_UNIDAD').AsString := FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNIDAD').AsString;
      FCdsItensParaValidacao.FieldByName('ITE_UNITAR').AsFloat  := FCdsItensParaValidacaoAnalitico.FieldByName('ITE_UNITAR').AsFloat;
      FCdsItensParaValidacao.FieldByName('ITE_SALDO_').AsFloat  := FCdsItensParaValidacaoAnalitico.FieldByName('ITE_SALDO_').AsFloat;
      FCdsItensParaValidacao.Post;
    End
    Else
    Begin
      FCdsItensParaValidacao.Edit;
      FCdsItensParaValidacao.FieldByName('ITE_SALDO_').AsFloat  := FCdsItensParaValidacao.FieldByName('ITE_SALDO_').AsFloat +
                                                                   FCdsItensParaValidacaoAnalitico.FieldByName('ITE_SALDO_').AsFloat;
      FCdsItensParaValidacao.Post;
    End;

    FCdsItensParaValidacaoAnalitico.Next;
  End;

end;

procedure TfrmFaturamentoConsignacaoDefinicaoItensRetorno.pCriarDataSets;
begin
  FCdsItensDoEnvio := TUniClientDataSet.Create(nil);
  FCdsItensDoEnvio.FieldDefs.Add('ID_NOTA_GE', ftString,  23, False);
  FCdsItensDoEnvio.FieldDefs.Add('ID_NOTA_EN', ftString,  23, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_CODITE', ftString,   8, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_DESITE', ftString, 100, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_UNDRET', ftString,  10, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_UNDENV', ftString,  10, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_QTDITE', ftFloat ,   0, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_UNIRET', ftFloat ,   0, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_UNITAR', ftFloat ,   0, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_NUMDOC', ftString,  12, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_ESPDOC', ftString,   3, False);
  FCdsItensDoEnvio.FieldDefs.Add('ITE_EMPDOC', ftString,   3, False);
  FCdsItensDoEnvio.CreateDataSet;
  FCdsItensDoEnvio.Open;

  FCdsItensParaValidacao := TUniClientDataSet.Create(nil);
  FCdsItensParaValidacao.FieldDefs.Add('ITE_CODITE', ftString,   8, False);
  FCdsItensParaValidacao.FieldDefs.Add('ITE_DESITE', ftString, 100, False);
  FCdsItensParaValidacao.FieldDefs.Add('ITE_SALDO_', ftFloat ,   0, False);
  FCdsItensParaValidacao.FieldDefs.Add('ITE_UNIDAD', ftString,  10, False);
  FCdsItensParaValidacao.FieldDefs.Add('ITE_UNITAR', ftFloat ,   0, False);
  FCdsItensParaValidacao.CreateDataSet;
  FCdsItensParaValidacao.Open;

  FCdsItensParaValidacaoAnalitico := TUniClientDataSet.Create(nil);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('AUTOINCREM', ftString,  23, False);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('ITE_CODITE', ftString,   8, False);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('ITE_DESITE', ftString, 100, False);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('ITE_SALDO_', ftFloat ,   0, False);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('ITE_UNIDAD', ftString,  10, False);
  FCdsItensParaValidacaoAnalitico.FieldDefs.Add('ITE_UNITAR', ftFloat ,   0, False);
  FCdsItensParaValidacaoAnalitico.CreateDataSet;
  FCdsItensParaValidacaoAnalitico.Open;

  FQueryNotaGerada.First;
  while not (FQueryNotaGerada.Eof) do
  begin
    FCdsItensDoEnvio.Append;

    FCdsItensDoEnvio.FieldByName('ID_NOTA_GE').AsString := FQueryNotaGerada.FieldByName('AUTOINCREM').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_CODITE').AsString := FQueryNotaGerada.FieldByName('DET_CODITE').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_DESITE').AsString := fCampoTabela('ITE_DESITE', 'CADITE', ['ITE_CODITE'],
                                                           [FQueryNotaGerada.FieldByName('DET_CODITE').AsString]);
    FCdsItensDoEnvio.FieldByName('ITE_UNDRET').AsString := FQueryNotaGerada.FieldByName('DET_UNIDAD').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_QTDITE').AsFloat  := FQueryNotaGerada.FieldByName('DET_QTDITE').AsFloat;
    FCdsItensDoEnvio.FieldByName('ITE_UNIRET').AsFloat  := FQueryNotaGerada.FieldByName('DET_UNITAR').AsFloat;

    if FTipoRetornoConsignacao = ttrImportacaoXML then
    begin
      FQueryNotaEnvio.Close;
      FQueryNotaEnvio.ParamByName('AUTINC').AsString := strListIdGerEle[0];
      FQueryNotaEnvio.ParamByName('CODITE').AsString := FQueryNotaGerada.FieldByName('DET_CODITE').AsString;
      FQueryNotaEnvio.Open;
    end
    Else
    Begin
      FQueryNotaEnvio.Close;
      FQueryNotaEnvio.ParamByName('NUMDOC').AsString := FQueryNotaGerada.FieldByName('DET_DOCDEV').AsString;
      FQueryNotaEnvio.ParamByName('ESPDOC').AsString := FQueryNotaGerada.FieldByName('DET_ESPDEV').AsString;
      FQueryNotaEnvio.ParamByName('CODEMP').AsString := FQueryNotaGerada.FieldByName('DET_EMPDEV').AsString;
      FQueryNotaEnvio.ParamByName('CODITE').AsString := FQueryNotaGerada.FieldByName('DET_CODITE').AsString;
      FQueryNotaEnvio.ParamByName('CODCLI').AsString := FQueryNotaGerada.FieldByName('DET_CODCLI').AsString;
      FQueryNotaEnvio.Open;
    End;

    pAlimentarCdsAnaliticoItensParaValidacao;

    {************************************************************************
    Neste ponto é onde vai buscar na nota de envio o relacionado a nota de
    retorno, comparando o unitario e a UN. Se não achar relação vai sugerir
    o último registro da nota de envio para o item em questão
    {********************************************************************GD*}
    FQueryNotaEnvio.First;
    while not FQueryNotaEnvio.Eof do
    Begin
      if (FQueryNotaEnvio.FieldByName('DET_UNITAR').AsFloat  = FQueryNotaGerada.FieldByName('DET_UNITAR').AsFloat) and
         (FQueryNotaEnvio.FieldByName('DET_UNIDAD').AsString = FQueryNotaGerada.FieldByName('DET_UNIDAD').AsString) then
        Break;
      FQueryNotaEnvio.Next;
    End;

    FCdsItensDoEnvio.FieldByName('ID_NOTA_EN').AsString := FQueryNotaEnvio.FieldByName('AUTOINCREM').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_NUMDOC').AsString := FQueryNotaEnvio.FieldByName('DET_NUMDOC').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_ESPDOC').AsString := FQueryNotaEnvio.FieldByName('DET_ESPDOC').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_EMPDOC').AsString := FQueryNotaEnvio.FieldByName('DET_CODEMP').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_UNDENV').AsString := FQueryNotaEnvio.FieldByName('DET_UNIDAD').AsString;
    FCdsItensDoEnvio.FieldByName('ITE_UNITAR').AsFloat  := FQueryNotaEnvio.FieldByName('DET_UNITAR').AsFloat;

    FCdsItensDoEnvio.Post;

    FQueryNotaGerada.next;
  end;

  pAlimentarCdsItensParaValidacao;
end;

end.
