unit untConsultaEstoqueApis;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, ancora.comunicacao, Uni, EditFocus, cxProgressBar,
  Vcl.CheckLst, Cotacao.ApiPrecos.ConstAndTypes, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxEdit,
  cxDataControllerConditionalFormattingRulesManagerDialog, cxClasses, cxVGrid,
  cxInplaceContainer, PitStop.Comunicacao, PitStop.Classes.EndPoint,
  cxCurrencyEdit, Vcl.Samples.Spin,
  SkyPecas.Classes.Base, SkyPecas.Classes.EndPoint, SkyPecas.Comunicacao, Data.DB;

type
  TObjList = class(TObject)
    id: integer;
    Nome: string;
  end;

  TfrmConsultaEstoqueApis = class(TfrmPai)
    pnlCodBar: TPanel;
    Label5: TLabel;
    edtCodEan: TEditFocus;
    pnlCodFab: TPanel;
    Label2: TLabel;
    edtCodFab: TEditFocus;
    lblAddmarca: TLabel;
    edtMarca: TEditFocus;
    BitBtnLocked1: TBitBtnLocked;
    GroupBox1: TGroupBox;
    lblNome: TLabel;
    lblCodFab: TLabel;
    lblMarca: TLabel;
    lblRetNome: TLabel;
    lblRetCodFab: TLabel;
    lblRetMarca: TLabel;
    btnBuscar: TBitBtnLocked;
    pnlApis: TPanel;
    chkConsultaAPI: TCheckListBox;
    Label3: TLabel;
    Panel5: TPanel;
    cxVerticalGrid1: TcxVerticalGrid;
    rowAncora: TcxEditorRow;
    RowPitStop: TcxEditorRow;
    cxStyleRepository1: TcxStyleRepository;
    cxStyle1: TcxStyle;
    cxTitleEstoque: TcxEditorRow;
    cxStyle2: TcxStyle;
    cxVerticalGrid2: TcxVerticalGrid;
    cxTitlePreco: TcxEditorRow;
    cxPrecoAncora: TcxEditorRow;
    cxPrecoPitStop: TcxEditorRow;
    pnlQuantidade: TPanel;
    Label1: TLabel;
    spdQuantidade: TSpinEdit;
    rowSkyPecas: TcxEditorRow;
    cxPrecoSkyPecas: TcxEditorRow;
    rowDelta: TcxEditorRow;
    cxPrecoDelta: TcxEditorRow;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
    procedure btnBuscarClick(Sender: TObject);
    procedure pProcessaRedePitStop;
    procedure pProcessaRedeSkyPecas;
    procedure pProcessaDelta;
    procedure pProcessaRedeAncora;
    procedure chkConsultaAPIClickCheck(Sender: TObject);


  private
    FRedeAncora : TRedeAncora;
    qryConsulta: TUniQuery;
    qryComand: TUniQuery;
    procedure AjustaTelaDelta(blnDeltaAtivo: Boolean);
    function fEhDelta: Boolean;
    function fImportandoAncora(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fImportandoPitStop(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fImportandoSkyPecas(pgbStatus: TcxProgressBar = Nil): Boolean;
    function fImportandoDelta(pgbStatus: TcxProgressBar = Nil): Boolean;
    procedure pDefineFocoCodFabMarca;
  protected
    strCodbar: String;
    strMarca: String;
    strCodFab: String;
    function fCalculaPrecoDeVendaCotacao(APrecus: Double): Double;
    procedure pGravaLog(ACODFAB, ACODBAR, ADESMAR, AFORNEC: String;
                       AIDIAPI: Integer; APRECO,  AESTOQ: Double; aFalha: string);

    { Private declarations }
  public
    FCodIte: String;
    class procedure pConsultaFullSearch(ACodIte: String);
    { Public declarations }
  end;

implementation

uses
  Ancora.Classes.EndPoint, untFuncoesSimples, untGravando,
  untCfgRelacionaFornecedorSkyFornecedorAutcom,
  untCfgHabilitaConsultaCotacaoAPIBalcao, Delta.comunicacao,
  Delta.Classes.EndPoint;

{$R *.dfm}

{ TfrmConsultaProdutoAncora }

procedure TfrmConsultaEstoqueApis.AjustaTelaDelta(blnDeltaAtivo: Boolean);
begin
  cxVerticalGrid2.Visible := Not blnDeltaAtivo;
  lblAddmarca.Visible := Not blnDeltaAtivo;
  edtMarca.Visible := Not blnDeltaAtivo;
  pnlCodBar.Visible := Not blnDeltaAtivo;
  If pnlCodBar.Visible Then
    pnlCodBar.Top := pnlApis.Top + 1;

  cxVerticalGrid1.Width := 295 + IIf(blnDeltaAtivo, 104, 0);
  rowDelta.Visible := blnDeltaAtivo;
  cxPrecoDelta.Visible := blnDeltaAtivo;

  If blnDeltaAtivo Then
  begin
    rowAncora.Visible := False;
    cxPrecoAncora.Visible := False;
    RowPitStop.Visible := False;
    cxPrecoPitStop.Visible := False;
    rowSkyPecas.Visible := False;
    cxPrecoSkyPecas.Visible := False;
  End;

end;

procedure TfrmConsultaEstoqueApis.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  // edtCodCna.Clear;
  edtCodEan.Clear;
  edtCodFab.Clear;
  EdtMarca.Clear;
  lblRetNome.Caption := '';
  lblRetCodFab.Caption := '';
  lblRetMarca.Caption := '';
  pSetFocus(edtCodEan);
  rowAncora.Properties.Value := '';
  cxPrecoAncora.Properties.Value := '';
  RowPitStop.Properties.Value := '';
  cxPrecoPitStop.Properties.Value := '';

  rowSkyPecas.Properties.Value := '';
  cxPrecoSkyPecas.Properties.Value := '';

  spdQuantidade.Value := 1;
end;

procedure TfrmConsultaEstoqueApis.FormCreate(Sender: TObject);
var ObjList: TObjList;
    blnTemDelta: Boolean;
    indexDelta: integer;
begin
  inherited;
  qryConsulta := fCriaQuery;
  qryComand := fCriaQuery;
  spdQuantidade.Value := 1;
  qryConsulta.SQL.Add('SELECT API_NOMAPI, APIBAL.* FROM APICOT');
  qryConsulta.SQL.Add(' INNER JOIN APIBAL ON API_ID_API = API_IDENTI');
  qryConsulta.SQL.Add(' WHERE API_CODEMP = "' + VS_StrCodEmp + '"');
  qryConsulta.SQL.Add('   AND API_HABILI = 1');
  qryConsulta.SQL.Add('   AND API_HABBAL = 1');
  qryConsulta.SQL.Add(' ORDER BY API_IDENTI');

  qryConsulta.Open;
  blnTemDelta := False;
  indexDelta := -1;
  while not qryConsulta.Eof Do
  begin
    ObjList := TObjList.Create;
    ObjList.id := qryConsulta.FieldByName('API_ID_API').AsInteger;
    ObjList.Nome := qryConsulta.FieldByName('API_NOMAPI').AsString;
    chkConsultaAPI.AddItem(qryConsulta.FieldByName('API_NOMAPI').AsString, ObjList);
    chkConsultaAPI.Checked[chkConsultaAPI.Items.Count -1] := True;
    case  qryConsulta.FieldByName('API_ID_API').AsInteger of
      idRedeAncora: begin
                      rowAncora.Visible := true;
                      cxPrecoAncora.Visible := true;
                    end;

      idRedePitStop: Begin
                       RowPitStop.Visible := true;
                       cxPrecoPitStop.Visible := true;
                       pnlQuantidade.Visible := True;
                       pnlQuantidade.Top := pnlCodFab.Top + 1;

                     End;
      idRedeSkyPecas: begin
                        rowSkyPecas.Visible := true;
                        cxPrecoSkyPecas.Visible := true;
                      end;
       idRedeDelta: begin
                      rowDelta.Visible := true;
                      cxPrecoDelta.Visible := true;
                      blnTemDelta := True;
                      indexDelta :=  chkConsultaAPI.Items.Count -1;
                    end;
    End;
    qryConsulta.Next;
  End;

  If (qryConsulta.RecordCount > 1) And blnTemDelta Then
    chkConsultaAPI.Checked[indexDelta] := False;
  If (qryConsulta.RecordCount = 1) And blnTemDelta Then
    AjustaTelaDelta(True)
  Else
    AjustaTelaDelta(False);
  qryConsulta.Close;
  qryConsulta.SQL.Clear;

end;

procedure TfrmConsultaEstoqueApis.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  FreeAndNil(qryComand);
  inherited;
end;

class procedure TfrmConsultaEstoqueApis.pConsultaFullSearch(ACodIte: String);
var frmConsultaEstoqueApis : TfrmConsultaEstoqueApis;
begin
  pCriarFormularios(TfrmConsultaEstoqueApis, frmConsultaEstoqueApis);
  Try
    frmConsultaEstoqueApis.strCodbar := '';
    frmConsultaEstoqueApis.strMarca := '';
    frmConsultaEstoqueApis.strCodFab := '';
    if TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fBalcaoHabilitado then
    Begin
      frmConsultaEstoqueApis.FRedeAncora := TRedeAncora.Create;
      If Not frmConsultaEstoqueApis.FRedeAncora.RetApiProfile.TemWarehouses Then
        frmConsultaEstoqueApis.FRedeAncora.fGetProfile;
    End;

    If Not fEmptyStr(ACodIte) Then
    begin
      frmConsultaEstoqueApis.qryConsulta.SQL.Clear;
      frmConsultaEstoqueApis.qryConsulta.SQL.Add('SELECT C.ITE_CODITE,  C.ITE_CODBAR, M.MAR_DESMAR, C.ITE_CODFAB, C.ITE_DESITE');
      frmConsultaEstoqueApis.qryConsulta.SQL.Add('  FROM CADITE C');
      frmConsultaEstoqueApis.qryConsulta.SQL.Add('  LEFT JOIN CADMAR M ON M.MAR_CODMAR = C.ITE_CODMAR');
      frmConsultaEstoqueApis.qryConsulta.SQL.Add(' WHERE TRUE');
      frmConsultaEstoqueApis.qryConsulta.SQL.Add('   AND C.ITE_CODITE = :CODITE');
      frmConsultaEstoqueApis.qryConsulta.ParamByName('CODITE').AsString := ACodIte;
      frmConsultaEstoqueApis.qryConsulta.Open;

      If Not frmConsultaEstoqueApis.qryConsulta.IsEmpty Then
      begin
        If not fEmptyStr(frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODBAR').AsString) Then
          frmConsultaEstoqueApis.edtCodEan.Text := frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODBAR').AsString
        Else If (not fEmptyStr(frmConsultaEstoqueApis.qryConsulta.FieldByName('MAR_DESMAR').AsString)) and
                (not fEmptyStr(frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODFAB').AsString)) Then
        begin
          frmConsultaEstoqueApis.EdtMarca.Text := frmConsultaEstoqueApis.qryConsulta.FieldByName('MAR_DESMAR').AsString;
          frmConsultaEstoqueApis.edtCodFab.Text := frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODFAB').AsString;

          frmConsultaEstoqueApis.strCodbar := frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODBAR').AsString;
          frmConsultaEstoqueApis.strMarca := frmConsultaEstoqueApis.qryConsulta.FieldByName('MAR_DESMAR').AsString;
          frmConsultaEstoqueApis.strCodFab := frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODFAB').AsString;

        end;

        If TfrmCfgHabilitaConsultaCotacaoAPIBalcao.fBalcaoHabilitado(idRedeDelta) Then
          frmConsultaEstoqueApis.edtCodFab.Text := frmConsultaEstoqueApis.qryConsulta.FieldByName('ITE_CODFAB').AsString;

      End;


    End;

    frmConsultaEstoqueApis.ShowModal;
  Finally
    FreeAndNil(frmConsultaEstoqueApis.FRedeAncora);
    FreeAndNil(frmConsultaEstoqueApis);
  End;
end;

procedure TfrmConsultaEstoqueApis.pDefineFocoCodFabMarca;
begin
  If fEmptyStr(edtCodFab.Text) Then
    pSetFocus(edtCodFab)
  Else
    pSetFocus(edtMarca)
  {}
end;

procedure TfrmConsultaEstoqueApis.pGravaLog(ACODFAB, ACODBAR, ADESMAR,
  AFORNEC: String; AIDIAPI: Integer; APRECO, AESTOQ: Double; aFalha: string);
begin
  Try
    qryComand.SQL.Clear;
    qryComand.SQL.Add('INSERT INTO LOGINC(');
    qryComand.SQL.Add('LOG_CODEMP,');
    qryComand.SQL.Add('LOG_CODFAB,');
    qryComand.SQL.Add('LOG_CODBAR,');
    qryComand.SQL.Add('LOG_DESMAR,');
    qryComand.SQL.Add('LOG_IDIAPI,');
    qryComand.SQL.Add('LOG_FORNEC,');
    qryComand.SQL.Add('LOG_PRECO_,');
    qryComand.SQL.Add('LOG_FALHA_,');
    qryComand.SQL.Add('LOG_ESTOQU)');
    qryComand.SQL.Add('VALUES(');
    qryComand.SQL.Add(':LOG_CODEMP,');
    qryComand.SQL.Add(':LOG_CODFAB,');
    qryComand.SQL.Add(':LOG_CODBAR,');
    qryComand.SQL.Add(':LOG_DESMAR,');
    qryComand.SQL.Add(':LOG_IDIAPI,');
    qryComand.SQL.Add(':LOG_FORNEC,');
    qryComand.SQL.Add(':LOG_PRECO_,');
    qryComand.SQL.Add(':LOG_FALHA_,');
    qryComand.SQL.Add(':LOG_ESTOQU)');

    qryComand.ParamByName('LOG_CODEMP').Value := VS_strCodEmp;
    qryComand.ParamByName('LOG_CODFAB').Value := ACODFAB;
    qryComand.ParamByName('LOG_CODBAR').Value := ACODBAR;
    qryComand.ParamByName('LOG_DESMAR').Value := ADESMAR;
    qryComand.ParamByName('LOG_IDIAPI').Value := AIDIAPI;
    qryComand.ParamByName('LOG_FORNEC').Value := AFORNEC;
    qryComand.ParamByName('LOG_PRECO_').Value := APRECO;
    qryComand.ParamByName('LOG_ESTOQU').Value := AESTOQ;
    qryComand.ParamByName('LOG_FALHA_').Value := AESTOQ;

    qryComand.ExecSQL;
  Except
    {Se der erro não deve interromper o processo}
  End;
end;

procedure TfrmConsultaEstoqueApis.btnBuscarClick(Sender: TObject);
var i: integer;
begin
  If fEhDelta Then
  begin
    If (fEmptyStr(edtCodFab.Text)) Then
    begin
      pMensagemOk('Para consultar o Código de Fábrica deve estar preenchido!');
      pDefineFocoCodFabMarca;
      Exit;
    End;

  End
  Else
  If (Not(fEmptyStr(edtCodFab.Text))) xor (Not(fEmptyStr(EdtMarca.Text))) then
  begin
    pMensagemOk('Para consultar por Código de Fábrica + marca, os dois campos devem estar preenchidos!');
    pDefineFocoCodFabMarca;
    Exit;
  End;

  If fEmptyStr(edtCodEan.Text  + edtCodFab.Text + edtCodFab.Text) then
  begin
    pMensagemOk('Para consultar, pelo menos um filtro deve ser preenchido!');
    Exit;
  end;

  lblRetNome.Caption := '';
  lblRetCodFab.Caption := '';
  lblRetMarca.Caption := '';
  rowAncora.Properties.Value := '';
  rowPitStop.Properties.Value := '';


  For i := 0 To chkConsultaAPI.Items.Count -1 do
  begin
    If chkConsultaAPI.Checked[i] Then
      case TObjList(chkConsultaAPI.Items.Objects[i]).id  of
        idRedeAncora: pProcessaRedeAncora;
        idRedePitStop: pProcessaRedePitStop;
        idRedeSkyPecas: pProcessaRedeSkyPecas;
        idRedeDelta: pProcessaDelta;
      End
   end;
end;

procedure TfrmConsultaEstoqueApis.chkConsultaAPIClickCheck(Sender: TObject);
var visible : Boolean;
    index: integer;
    lItemIndex: integer;
begin
  inherited;

  visible := chkConsultaAPI.Checked[chkConsultaAPI.ItemIndex];
  lItemIndex := chkConsultaAPI.ItemIndex;
  case TObjList(chkConsultaAPI.Items.Objects[chkConsultaAPI.ItemIndex]).id of
    idRedeAncora: Begin
                    rowAncora.Visible := visible;
                    cxPrecoAncora.Visible := visible;
                    If visible Then
                      cxVerticalGrid2.Visible := True
                  End;
    idRedePitStop: Begin
                     RowPitStop.Visible := visible;
                     cxPrecoPitStop.Visible := visible;
                     pnlQuantidade.Visible := visible;
                     If visible Then
                       cxVerticalGrid2.Visible := True
                   End;
    idRedeSkyPecas: begin
                      rowSkyPecas.Visible := visible;
                      cxPrecoSkyPecas.Visible := visible;
                      If visible Then
                        cxVerticalGrid2.Visible := True
                    end;
    idRedeDelta: begin
                   {}
                 end;
  End;
  If (TObjList(chkConsultaAPI.Items.Objects[chkConsultaAPI.ItemIndex]).id = idRedeDelta) and visible then
  begin
    For index := 0 To chkConsultaAPI.Items.Count - 1 do
      If index <> lItemIndex Then
        chkConsultaAPI.Checked[index] := False;
    AjustaTelaDelta(True);

  End;

  If (TObjList(chkConsultaAPI.Items.Objects[chkConsultaAPI.ItemIndex]).id <> idRedeDelta) and visible then
  begin
    For index := 0 To chkConsultaAPI.Items.Count - 1 do
      If TObjList(chkConsultaAPI.Items.Objects[index]).id = idRedeDelta Then
      begin
        chkConsultaAPI.Checked[index] := False;
        AjustaTelaDelta(False);
      end;
  End;

end;

procedure TfrmConsultaEstoqueApis.pProcessaDelta;
var frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando Delta...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fImportandoDelta;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
end;

procedure TfrmConsultaEstoqueApis.pProcessaRedeAncora;
var frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando Rede Ancora...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fImportandoAncora;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
End;

procedure TfrmConsultaEstoqueApis.pProcessaRedePitStop;
var frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando Rede Pit Stop...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fImportandoPitStop;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
End;


procedure TfrmConsultaEstoqueApis.pProcessaRedeSkyPecas;
var frmGravando: TfrmGravando;
begin
  pCriarFormularios(TfrmGravando, frmGravando);
  Try
    frmGravando.lblGravando.Caption := 'Consultando Rede Sky Peças...';
    frmGravando.pgbStatus.Visible := False;
    frmGravando.fExecutarAcao := fImportandoSkyPecas;
    frmGravando.ShowModal;
  finally
    FreeAndNil(frmGravando);
  End;
end;

function TfrmConsultaEstoqueApis.fImportandoSkyPecas(pgbStatus: TcxProgressBar = Nil): Boolean;
  var
    RedeSkyPecas: TRedeSkyPecas;
    ParamSkyConsultaProduto: TParamSkyConsultaProduto;
begin
  Result := True;
  RedeSkyPecas := TRedeSkyPecas.Create;
  ParamSkyConsultaProduto := TParamSkyConsultaProduto.Create;
  Try
    Try
      If RedeSkyPecas.fLogin Then
      begin
        ParamSkyConsultaProduto.codigo_barras := edtCodEan.Text;
        ParamSkyConsultaProduto.codigo_fabrica := edtCodFab.Text;
        ParamSkyConsultaProduto.Marca := edtMarca.Text;
        ParamSkyConsultaProduto.Empresa := TfrmCfgRelacionaForncedorSkyFornecedorAutcom.fFornecedorSky(fCfgSis('SKYFBA'));
        If RedeSkyPecas.fBuscaPrecoProduto(ParamSkyConsultaProduto) Then
        begin
          If lblRetNome.Caption = '' Then
          Begin
            lblRetNome.Caption := ParamSkyConsultaProduto.RetornoProduto.descricao;
            lblRetCodFab.Caption := ParamSkyConsultaProduto.RetornoProduto.codigo_fabricante;
            lblRetMarca.Caption := ParamSkyConsultaProduto.RetornoProduto.marca;
          end;
          rowSkyPecas.Properties.Value := ParamSkyConsultaProduto.RetornoProduto.estoque;
          cxPrecoSkyPecas.Properties.Value := fCalculaPrecoDeVendaCotacao(ParamSkyConsultaProduto.RetornoProduto.valor);
        end;

      End
      Else
        pMensagemOk(RedeSkyPecas.ParamSkyPecas.RetornoApi.Falha);
    finally
      pGravaLog(edtCodFab.Text,
                edtCodEan.Text,
                EdtMarca.Text,
                fCfgSis('SKYFBA'),
                idRedeSkyPecas,
                ParamSkyConsultaProduto.RetornoProduto.estoque,
                ParamSkyConsultaProduto.RetornoProduto.valor,
                ParamSkyConsultaProduto.RetornoApi.Falha);
      freeAndNil(RedeSkyPecas);
      freeAndNil(ParamSkyConsultaProduto);
    End;
  Except
    on e:exception do
      pMensagensErro(e.message, '[TfrmConsultaEstoqueApis.fImportandoSkyPecas]');
  End;

end;


function TfrmConsultaEstoqueApis.fCalculaPrecoDeVendaCotacao(
  APrecus: Double): Double;
  var cfgMarBal: Double;
begin
  cfgMarBal := fCfgSis('MARBAL', varDouble);
  Result := APrecus;
  If cfgMarBal > 0 Then
    Result := fCalculaPrecoVenda(1,  APrecus, 0, cfgMarBal, 0,0,0,0);
end;

function TfrmConsultaEstoqueApis.fEhDelta: Boolean;
var i: integer;
begin
  Result := False;
  For i := 0 To chkConsultaAPI.Items.Count -1 do
    If chkConsultaAPI.Checked[i] Then
      Result := TObjList(chkConsultaAPI.Items.Objects[i]).id  = idRedeDelta;
end;

function TfrmConsultaEstoqueApis.fImportandoAncora(pgbStatus: TcxProgressBar = Nil): Boolean;
  var ParamnsFullSearch: TParamnsFullSearch;
      Falha: String;
begin
  Result := True;
  Try
    ParamnsFullSearch := TParamnsFullSearch.Create;
    Try
      ParamnsFullSearch.empresa := FRedeAncora.RetApiProfile.WareHousePreferencial;
      ParamnsFullSearch.brand := EdtMarca.Text;
      ParamnsFullSearch.code := edtCodFab.Text;
      ParamnsFullSearch.gtin := edtCodEan.Text;
      ParamnsFullSearch.fields := [prices,stocks];

      ParamnsFullSearch.cna := '';
      FRedeAncora.fRetFullSearch(ParamnsFullSearch);
      Falha := '';

      If Not ParamnsFullSearch.RetornoApi.Sucess then
      begin
        pMensagemOk('Retorno com erro: ' + ParamnsFullSearch.RetornoApi.Falha);
        Falha := ParamnsFullSearch.RetornoApi.Falha;
        Exit;
      end;

      lblRetNome.Caption := FRedeAncora.RetApiFullSearch.nome;
      lblRetCodFab.Caption := FRedeAncora.RetApiFullSearch.codFabrica;
      lblRetMarca.Caption := FRedeAncora.RetApiFullSearch.marca;
      rowAncora.Properties.Value := FRedeAncora.RetApiFullSearch.fltEstoque.ToString();
      cxPrecoAncora.Properties.Value := fCalculaPrecoDeVendaCotacao(FRedeAncora.RetApiFullSearch.fltPrecoComSt);
    finally
      pGravaLog(edtCodFab.Text,
                edtCodEan.Text,
                EdtMarca.Text,
                FRedeAncora.RetApiProfile.fLocateWareHousePreferencia.cgc,
                idRedeAncora,
                FRedeAncora.RetApiFullSearch.fltEstoque,
                FRedeAncora.RetApiFullSearch.fltPrecoComSt,
                ParamnsFullSearch.RetornoApi.Falha);
      freeAndNil(ParamnsFullSearch);
    End;
  Except
    on e:exception do
      pMensagensErro(e.message, '[TfrmConsultaProdutoAncora.fImportandoAncora]');
  End;
end;

function TfrmConsultaEstoqueApis.fImportandoDelta(pgbStatus: TcxProgressBar): Boolean;
  var lRedeDelta: TRedeDelta;
      lParamns: TParamnsConsultaEstoque;
begin
  Result := True;
  lRedeDelta := TRedeDelta.Create;
  lParamns := TParamnsConsultaEstoque.Create;
  Try
    lParamns.strCodigoFabrica := edtCodFab.Text;
    lRedeDelta.fConsultaEstoque(lParamns);
    If Not lParamns.RetornoApi.Sucess then
     begin
       pMensagemOk('Retorno com erro: ' + lParamns.RetornoApi.Falha);
     end;

     lblRetNome.Caption := lParamns.RetConsultaEstoque.dsc_item;
     lblRetCodFab.Caption := lParamns.RetConsultaEstoque.cod_produto;
     lblRetMarca.Caption := lParamns.RetConsultaEstoque.dsc_marca;
     rowDelta.Properties.Value := lParamns.RetConsultaEstoque.sdo_saldo_estoque;
     cxPrecoDelta.Properties.Value := 0
  finally
      pGravaLog(edtCodFab.Text,
                '',
                '',
                '',
                idRedeDelta,
                lParamns.RetConsultaEstoque.sdo_saldo_estoque,
                0,
                lParamns.RetornoApi.Falha);
    FreeAndNil(lRedeDelta);
    FreeAndNil(lParamns);
  End;
end;

function TfrmConsultaEstoqueApis.fImportandoPitStop(pgbStatus: TcxProgressBar): Boolean;
var RedePitStop: TRedePitStop;
    Paramns: TParamLista;
begin
  Result := True;
  Paramns :=  TParamLista.Create;
  RedePitStop := TRedePitStop.Create(fCfgSis('PSTCID'));

  Try
    Try
      Paramns.Cnpj_Cliente := fCfgSis('PSTCID');
      Paramns.Cnpj_Filial  := fCfgSis('PSTFBA');
      Paramns.PitStopTipoConsulta := pstcBalcao;
      Paramns.PrazoMedio := '60';
      Paramns.Quantidade := spdQuantidade.Value;
      Paramns.LogoMarca := 2;
      If fEmptyStr(edtCodFab.Text) And  fEmptyStr(edtMarca.Text) And (edtCodEan.Text = strCodbar) Then
        Paramns.pAddItemConsulta('', strCodFab, strMarca, edtCodEan.Text, Paramns.Quantidade)
      Else
        Paramns.pAddItemConsulta('', edtCodFab.Text, edtMarca.Text, edtCodEan.Text, Paramns.Quantidade);
      RedePitStop.fRetProcessaLista(Paramns);



      If Paramns.RetornoProduto.Erro <> '' Then
        RowPitStop.Properties.Value := 0
      Else
        RowPitStop.Properties.Value := Paramns.Quantidade;
      If lblRetNome.Caption = '' Then
      Begin
        lblRetCodFab.Caption := Paramns.RetornoProduto.codFabrica;
        lblRetMarca.Caption := Paramns.RetornoProduto.Marca;
        lblRetNome.Caption := Paramns.RetornoProduto.Item;
      end;

      cxPrecoPitStop.Properties.Value := fCalculaPrecoDeVendaCotacao(Paramns.RetornoProduto.PrecoUnitario);

    finally
      pGravaLog(edtCodFab.Text,
                edtCodEan.Text,
                EdtMarca.Text,
                Paramns.Cnpj_Filial,
                idRedePitStop,
                Paramns.Quantidade,
                Paramns.RetornoProduto.PrecoUnitario,
                Paramns.RetornoApi.Falha);

      freeAndNil(Paramns);
      freeAndNil(RedePitStop);
    End;
  Except
    on e:exception do
      pMensagensErro(e.message, '[TfrmConsultaProdutoAncora.fImportandoPitStop]');
  End;

end;

end.


