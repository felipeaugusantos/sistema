unit Contabilidade.View.AdicionaPlanoContas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Contabilidade.View.TfrmPaiConfirmaContabilidade, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, UniClientDataSet,
  EditFocus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untTypesSistema,
  Contabilidade.Interfaces.ConfigLucroPresumido,
  Contabilidade.Interfaces.SharedLucroPresumido;

type
  TfrmAdicionaPlanoContas = class(TfrmPaiConfirmaContabilidade)
    Label17: TLabel;
    edtPlanco: TEditFocus;
    edtDesPlanco: TEditFocus;
    btnAdicionar: TBitBtnLocked;
    dsPlanco: TDataSource;
    GridPlancoView: TcxGridDBTableViewCitel;
    GridPlancoLevel: TcxGridLevel;
    GridPlanco: TcxGridCitel;
    GridPlancoViewCODCON: TcxGridDBColumn;
    GridPlancoViewDESCRI: TcxGridDBColumn;
    GridPlancoViewTPLACO: TcxGridDBColumn;
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPlancoKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FcdsDetalhePlanco : TUniClientDataSet ;
    FcdsDetalhePlancoClonado : TUniClientDataSet ;
    FarrCons: TConsultasArray;
    FblConfirma: Boolean ;
    FstrCodigoFiltro: String ;
    FstrCodigoFiltroIrpj: String ;
    FtlpTipo: TTipoLucroPresumido ;
    FcdsDetalhe : TUniClientDataSet ;
    FcdsDetalheIrpj : TUniClientDataSet ;
    FcdsDetalhePlancoIrpj : TUniClientDataSet ;
    FcdsDetalheIrpjClonado : TUniClientDataSet ;
    FcdsDetalhePlancoIrpjClonado : TUniClientDataSet ;
    FcdsDetalheClonado : TUniClientDataSet ;
    FcdsDetalhePlancoDifClonado : TUniClientDataSet ;
    FstrColuna: String ;
    procedure pClonaDataSets ;
    function fValidaPlanoContabil(edtCodigo: TEditFocus; edtDscricao: TEditFocus): Boolean;
    procedure pCarregaPlanoContabil(strCodigo: String; edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean=False);
    function fCadastraPlanco(const AstrPlanco: String): Boolean ;
    function fVerificaSeContaEhUtilizadaEmOutrasConfigs: Boolean ;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    property CodigoFiltro: String read FstrCodigoFiltro write FstrCodigoFiltro ;
    property CodigoFiltroIrpj: String read FstrCodigoFiltroIrpj write FstrCodigoFiltroIrpj ;
    property cdsDetalhePlanco: TUniClientDataSet read FcdsDetalhePlanco write FcdsDetalhePlanco ;
    property cdsDetalhePlancoClonado: TUniClientDataSet read FcdsDetalhePlancoClonado ;
    property BlConfirma: Boolean read FblConfirma ;
    property Tipo: TTipoLucroPresumido read FtlpTipo write FtlpTipo ;
    property cdsDetalhe : TUniClientDataSet read FcdsDetalhe write FcdsDetalhe ;
    property cdsDetalheIrpj : TUniClientDataSet read FcdsDetalheIrpj write FcdsDetalheIrpj ;
    property cdsDetalhePlancoIrpj : TUniClientDataSet read FcdsDetalhePlancoIrpj write FcdsDetalhePlancoIrpj ;
  end;

implementation

uses
  untFuncoesSimples, Contabilidade.Consultas, Contabilidade.Funcoes,
  Contabilidade.Classes.ConfigLucroPresumidoComum ;

{$R *.dfm}

{ TfrmAdicionaPlanoContas }

procedure TfrmAdicionaPlanoContas.btnAdicionarClick(Sender: TObject);
begin
  inherited;

  if (fEmptyStr(edtPlanco.Text)) and (Length(FarrCons) = 0) then
  begin
    pSetFocus(edtPlanco) ;
    pMensagemOk('Plano de contas não informado!');
    exit ;
  end ;


  if fCadastraPlanco(edtPlanco.Text) then
  begin
    edtPlanco.Clear ;
    edtDesPlanco.Clear ;
    pSetFocus(edtPlanco) ;
    SetLength(FarrCons, 0);
    pMensagemOk('Incluído com sucesso!');
  end ;

end;

procedure TfrmAdicionaPlanoContas.btnConfirmaClick(Sender: TObject);
begin

  if fVerificaSeContaEhUtilizadaEmOutrasConfigs then
    Exit ;

  FblConfirma := True ;
  Close ;
end;

procedure TfrmAdicionaPlanoContas.edtPlancoKeyPress(Sender: TObject;
  var Key: Char);
Var
  LstrTpLaco: String ;
begin
  inherited;
  If fEntraCons(Key) Then
  Begin
    SetLength(FarrCons, 0);
    LstrTpLaco := fRetTplacoEmpresaLogada ;
    If fPesqPlanoContabil(Self, TEditFocus(Sender), edtDesPlanco, Nil, Key, FarrCons, False, LstrTpLaco, False, False) Then
    Begin
      If fValidaCampos(TEditFocus(Sender), True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;
end;

function TfrmAdicionaPlanoContas.fCadastraPlanco(
  const AstrPlanco: String): Boolean;
var
  LintCnt: Integer ;
  LstrTpLaco: String ;
begin
  LstrTpLaco := fRetTplacoEmpresaLogada ;
  FcdsDetalhePlancoClonado.DisableControls ;
  try
    if Length(FarrCons) = 0 then
    begin
      if not FcdsDetalhePlancoClonado.FindKey([AstrPlanco]) then
      begin
        FcdsDetalhePlancoClonado.Append ;
        FcdsDetalhePlancoClonado.FieldByName('CODCON').AsString := AstrPlanco ;
        FcdsDetalhePlancoClonado.FieldByName('DESCRI').AsString := edtDesPlanco.Text ;
        FcdsDetalhePlancoClonado.FieldByName('TPLACO').AsString := LstrTpLaco ;
        FcdsDetalhePlancoClonado.FieldByName('SEQGER').AsString := FstrCodigoFiltro ;
        FcdsDetalhePlancoClonado.Post ;
      end ;
    end
    else
    begin
      for LintCnt := Low(FarrCons) to High(FarrCons) do
      begin
        if not FcdsDetalhePlancoClonado.FindKey([FarrCons[LintCnt].strCodigo]) then
        begin
          FcdsDetalhePlancoClonado.Append ;
          FcdsDetalhePlancoClonado.FieldByName('CODCON').AsString := FarrCons[LintCnt].strCodigo ;
          FcdsDetalhePlancoClonado.FieldByName('DESCRI').AsString := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [FarrCons[LintCnt].strCodigo], False) ;
          FcdsDetalhePlancoClonado.FieldByName('TPLACO').AsString := LstrTpLaco ;
          FcdsDetalhePlancoClonado.FieldByName('SEQGER').AsString := FstrCodigoFiltro ;
          FcdsDetalhePlancoClonado.Post ;
        end ;
      end ;
    end ;
  finally
    FcdsDetalhePlancoClonado.EnableControls ;
  end ;
  Result := True ;
end;

procedure TfrmAdicionaPlanoContas.FormCreate(Sender: TObject);
begin
  inherited;
  FstrCodigoFiltroIrpj := '' ;
  FcdsDetalhePlancoClonado := Nil ;
  FcdsDetalheIrpjClonado := Nil ;
  FcdsDetalhePlancoIrpjClonado := Nil ;
  FcdsDetalheClonado := Nil ;
  FcdsDetalhePlancoDifClonado := Nil ;
  SetLength(FarrCons, 0);
  FblConfirma := False ;
end;

procedure TfrmAdicionaPlanoContas.FormDestroy(Sender: TObject);
begin
  inherited;
  if Assigned(FcdsDetalhePlancoClonado) then
    FreeAndNil(FcdsDetalhePlancoClonado) ;

  if Assigned(FcdsDetalheIrpjClonado) then
    FreeAndNil(FcdsDetalheIrpjClonado) ;

  if Assigned(FcdsDetalhePlancoIrpjClonado) then
    FreeAndNil(FcdsDetalhePlancoIrpjClonado) ;

  if Assigned(FcdsDetalheClonado) then
    FreeAndNil(FcdsDetalheClonado) ;

  if Assigned(FcdsDetalhePlancoDifClonado) then
    FreeAndNil(FcdsDetalhePlancoDifClonado) ;

end;

procedure TfrmAdicionaPlanoContas.FormShow(Sender: TObject);
begin
  inherited;
  FstrColuna := TColunaDetalhePlanco.New.fRetornaColuna(FcdsDetalhe.FieldByName('CODIGO').AsString) ;
  pClonaDatasets ;
  dsPlanco.DataSet := FcdsDetalhePlancoClonado ;
  FcdsDetalhePlancoClonado.First ;
end;

function TfrmAdicionaPlanoContas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  begin
    If (Sender = edtPlanco) Then
      Result := fValidaPlanoContabil(edtPlanco, edtDesPlanco);
  end ;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmAdicionaPlanoContas.fValidaPlanoContabil(edtCodigo,
  edtDscricao: TEditFocus): Boolean;
begin
  Result := True;

  if edtCodigo.Text = '00000000000000000000' then
    Exit ;

  If Not fEmptyStr(edtCodigo.Text) Then
  Begin
    pCarregaPlanoContabil(edtCodigo.Text, edtDscricao, True);

    If fEmptyStr(edtDscricao.Text) Then
    Begin
      fMensagem('ATENÇÃO!', 'Conta Contábil não encontrada!', ['&Ok']);
      edtDscricao.Clear;
      Result := False;
    End;
    SetLength(FarrCons, 0);
  End
  Else
  begin
    SetLength(FarrCons, 0);
    edtDscricao.Clear;
  end ;
end;

function TfrmAdicionaPlanoContas.fVerificaSeContaEhUtilizadaEmOutrasConfigs: Boolean;
var
  LstrMensagem: String ;
begin
  Result := True ;

  LstrMensagem := '' ;
  FcdsDetalhePlancoClonado.First ;
  while not FcdsDetalhePlancoClonado.Eof do
  begin

    if FcdsDetalhePlancoDifClonado.FindKey([FcdsDetalhePlancoClonado.FieldByName('CODCON').AsString]) then
    begin
      if FcdsDetalheClonado.Locate(FstrColuna, FcdsDetalhePlancoDifClonado.FieldByName('SEQGER').AsString, [loCaseInsensitive]) then
      begin

        LstrMensagem := LstrMensagem + 'Plano de Conta: ' + FcdsDetalhePlancoDifClonado.FieldByName('CODCON').AsString + #13#10 ;
        LstrMensagem := LstrMensagem + 'Sendo usada em: ' + FcdsDetalheClonado.FieldByName('DESCOD').AsString + '-' + FcdsDetalheClonado.FieldByName('DESCRI').AsString ;

        fMensagem('ATENÇÃO!', LstrMensagem, ['&OK']);
        Exit ;
      end ;
    end ;

    if not fEmptyStr(FstrCodigoFiltroIrpj) then
    begin
      if FcdsDetalhePlancoIrpjClonado.FindKey([FcdsDetalhePlancoClonado.FieldByName('CODCON').AsString]) then
      begin
        if FcdsDetalheIrpjClonado.Locate(FstrColuna, FcdsDetalhePlancoIrpjClonado.FieldByName('SEQGER').AsString, [loCaseInsensitive]) then
        begin
          LstrMensagem := LstrMensagem + 'IRPJ' + #13#10 ;
          LstrMensagem := LstrMensagem + 'Plano de Conta: ' + FcdsDetalhePlancoIrpjClonado.FieldByName('CODCON').AsString + #13#10 ;
          LstrMensagem := LstrMensagem + 'Sendo usada em: ' + FcdsDetalheIrpjClonado.FieldByName('DESCOD').AsString + '-' + FcdsDetalheIrpjClonado.FieldByName('DESCRI').AsString ;

          fMensagem('ATENÇÃO!', LstrMensagem, ['&OK']);
          Exit ;
        end ;
      end ;
    end ;


    FcdsDetalhePlancoClonado.Next ;
  end ;
  FcdsDetalhePlancoClonado.First ;

  Result := False ;
end;

procedure TfrmAdicionaPlanoContas.pCarregaPlanoContabil(strCodigo: String;
  edtDscricao: TEditFocus; const blnBuscaPorChave: Boolean);
begin
  If Not fEmptyStr(strCodigo) Then
  begin
    if blnBuscaPorChave then
    begin
      edtDscricao.Text := fCampoTabelaPlanco('NCO_DESCRI', ['NCO_CODCON'], [strCodigo], False);
    end
    else
    begin
      edtDscricao.Text := fCampoTabela('NCO_DESCRI', 'PLANCO', ['NCO_CODCON'], [strCodigo], False);
    end;
  end
  Else
  begin
    edtDscricao.Clear;
  end;
end;

procedure TfrmAdicionaPlanoContas.pClonaDataSets;
begin
  FcdsDetalhePlancoClonado := TUniClientDataSet.Create(nil);
  pCloneDataSet(FcdsDetalhePlancoClonado, FcdsDetalhePlanco);

  FcdsDetalheIrpjClonado := TUniClientDataSet.Create(nil);
  pCloneDataSet(FcdsDetalheIrpjClonado, FcdsDetalheIrpj);

  FcdsDetalhePlancoIrpjClonado := TUniClientDataSet.Create(nil);
  pCloneDataSet(FcdsDetalhePlancoIrpjClonado, FcdsDetalhePlancoIrpj);

  FcdsDetalheClonado := TUniClientDataSet.Create(nil);
  pCloneDataSet(FcdsDetalheClonado, FcdsDetalhe) ;

  FcdsDetalhePlancoDifClonado := TUniClientDataSet.Create(nil);
  pCloneDataSet(FcdsDetalhePlancoDifClonado, FcdsDetalhePlanco) ;

  FcdsDetalhePlancoClonado.IndexFieldNames := 'CODCON' ;
  FcdsDetalhePlancoClonado.Filtered := False ;
  FcdsDetalhePlancoClonado.Filter := 'SEQGER = ' + fQuotedStr(FstrCodigoFiltro) ;
  FcdsDetalhePlancoClonado.Filtered := True ;


  FcdsDetalheClonado.Filtered := False ;
  FcdsDetalheClonado.Filter := FstrColuna + ' <> ' + fQuotedStr(FstrCodigoFiltro) ;
  FcdsDetalheClonado.Filtered := True ;

  FcdsDetalhePlancoDifClonado.IndexFieldNames := 'CODCON' ;
  FcdsDetalhePlancoDifClonado.Filtered := False ;
  FcdsDetalhePlancoDifClonado.Filter := 'SEQGER <> ' + fQuotedStr(FstrCodigoFiltro) ;
  FcdsDetalhePlancoDifClonado.Filtered := True ;

  if not fEmptyStr(FstrCodigoFiltroIrpj) then
  begin
    FcdsDetalheIrpjClonado.Filtered := False ;
    FcdsDetalheIrpjClonado.Filter := FstrColuna + ' <> ' + fQuotedStr(FstrCodigoFiltroIrpj) ;
    FcdsDetalheIrpjClonado.Filtered := True ;

    FcdsDetalhePlancoIrpjClonado.IndexFieldNames := 'CODCON' ;
    FcdsDetalhePlancoIrpjClonado.Filtered := False ;
    FcdsDetalhePlancoIrpjClonado.Filter := 'SEQGER <> ' + fQuotedStr(FstrCodigoFiltroIrpj) ;
    FcdsDetalhePlancoIrpjClonado.Filtered := True ;
  end ;

end;

end.
