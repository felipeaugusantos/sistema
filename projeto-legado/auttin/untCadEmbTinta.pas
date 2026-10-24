unit untCadEmbTinta;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit, DB,
  cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, EditFocus,
  Uni, UniClientDataSet,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient;

type
  TfrmCadEmbTinta = class(TfrmPai)
    pnlGeral: TPanel;
    pnlProdutos: TPanel;
    cxgEmbala: TcxGrid;
    cxgEmbalaView: TcxGridDBTableView;
    cxgEmbalaLevel1: TcxGridLevel;
    grbProdutos: TGroupBox;
    Label1: TLabel;
    edtProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosPRINCI: TStringField;
    cdsProdutosDESCRI: TStringField;
    cxgEmbalaViewCODITE: TcxGridDBColumn;
    cxgEmbalaViewDESCRI: TcxGridDBColumn;
    cxgEmbalaViewPRINCI: TcxGridDBColumn;
    btnConfirma: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgEmbalaViewPRINCIPropertiesChange(Sender: TObject);
  private
    { Private declarations }
    qryCadIte: TUniQuery;
    strCodCfgEmb: String;
    strIdeProEmb: String;
    strEmbalaEmb: String;
    strLinha_Emb: String;
    blnGravou: Boolean;

    procedure pConsultaItem(edtItem, edtDesIte: TEdit);
    procedure pRetornaDescricaoItem(edtCodIte: TEdit);
    procedure pLimparTela;
    procedure pAdicinar;
    procedure pGravarNaTabela;
    procedure pExcluirDaTabela;
    procedure pGravar;
    procedure pExcluir;
    procedure pConsultaEmbalagem;
    procedure pAtualizaItemPrincipal;
    procedure pMarcaItemPrincipal;
    procedure pUpdateItemPrincipal(strCodIte, strValor: String);

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pSetaParametros(strCodCfg, strIdePro, strEmbala, strLinha_: String);
  end;

var
  frmCadEmbTinta: TfrmCadEmbTinta;

implementation

uses untConstantes, untFuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadEmbTinta.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    pAdicinar;
    pLimparTela;
    cxgEmbala.Enabled := False;
  End;
end;

procedure TfrmCadEmbTinta.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparTela;
end;

procedure TfrmCadEmbTinta.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  pGravarNaTabela;
end;

procedure TfrmCadEmbTinta.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pExcluirDaTabela;
  pSetFocus(edtProduto);
end;

procedure TfrmCadEmbTinta.cxgEmbalaViewPRINCIPropertiesChange(Sender: TObject);
begin
  inherited;
  pAtualizaItemPrincipal;
end;

procedure TfrmCadEmbTinta.edtProdutoKeyPress(Sender: TObject; var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDesProduto'));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

procedure TfrmCadEmbTinta.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  If Not blnGravou Then
  Begin
    fMensagem('ATENÇÃO','É preciso cadastrar uma embalagem!',['&OK']);
    Abort;
  End
  Else
    cdsProdutos.EmptyDataSet;
  FreeAndNil(qryCadIte);
end;

procedure TfrmCadEmbTinta.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadIte := fCriaQuery(Self);
  cdsProdutos.CreateDataSet;
end;

procedure TfrmCadEmbTinta.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
    VK_F9 :btnExcluir.Click;    
  End;
end;

procedure TfrmCadEmbTinta.FormShow(Sender: TObject);
begin
  inherited;
  pConsultaEmbalagem;
  pSetFocus(edtProduto);
end;

function TfrmCadEmbTinta.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (Sender = edtProduto) Then
  Begin
    If (fEmptyStr(edtProduto.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Todos os itens devem ser preenchidos!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProduto);
      edtDesIte := TEdit(FindComponent('edtDesProduto'));
      If (fEmptyStr(edtDesIte.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End;
end;

procedure TfrmCadEmbTinta.pAdicinar;
begin
  With cdsProdutos Do
  Begin
    Append;
    FieldByName('CODITE').AsString := edtProduto.Text;
    FieldByName('DESCRI').AsString := edtDesProduto.Text;
    FieldByName('PRINCI').AsString := IIF(RecordCount = 0,'S','N');
    Post;

    btnConfirma.Enabled := True;
  End;
end;

procedure TfrmCadEmbTinta.pAtualizaItemPrincipal;
begin
  pMarcaItemPrincipal
end;

procedure TfrmCadEmbTinta.pConsultaEmbalagem;
var
  qryCon: TUniQuery;
begin
  Try
    Try
      qryCon := fCriaQuery(Nil);
      With qryCon Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' SELECT CFG_CODITE, CFG_PRINCI ');
        SQL.Add('   FROM CFGEMB ');
        SQL.Add('  WHERE CFG_CODEMP = :CODEMP ');
        SQL.Add('    AND CFG_IDEPRO = :IDEPRO ');
        SQL.Add('    AND CFG_CODCFG = :CODCFG ');
        SQL.Add('    AND CFG_EMBALA = :EMBALA ');
        SQL.Add('    AND CFG_LINHA_ = :LINHA_ ');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('IDEPRO').AsString := strIdeProEmb;
        ParamByName('CODCFG').AsString := strCodCfgEmb;
        ParamByName('EMBALA').AsString := strEmbalaEmb;
        ParamByName('LINHA_').AsString := strLinha_Emb;
        Open;

        If Not IsEmpty Then
        Begin
          First;
          While not Eof Do
          Begin
            cdsProdutos.Append;
            cdsProdutosCODITE.AsString := FieldByName('CFG_CODITE').AsString;
            cdsProdutosDESCRI.AsString := fRetNomGeral('ITE_DESITE','ITE_CODITE','CADITE', fStrToFloat(FieldByName('CFG_CODITE').AsString));
            cdsProdutosPRINCI.AsString := FieldByName('CFG_PRINCI').AsString;
            cdsProdutos.Post;

            Next;
          End;
          First;
        End;

        blnGravou := Not cdsProdutos.IsEmpty;

      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[pConsultaEmbalagem]');
      end;
    End;
  Finally
    FreeAndNil(qryCon);
  End;
end;

procedure TfrmCadEmbTinta.pConsultaItem(edtItem, edtDesIte: TEdit);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqItem(conIteSimples, Self, edtItem, edtDesIte, nil, Key, arrSel) Then
    SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadEmbTinta.pExcluir;
var
  qryDel: TUniQuery;
begin
  Try
    Try
      qryDel := fCriaQuery(Nil);
      With qryDel Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' DELETE FROM CFGEMB ');
        SQL.Add(' WHERE CFG_CODEMP = :CODEMP ');
        SQL.Add('   AND CFG_IDEPRO = :IDEPRO ');
        SQL.Add('   AND CFG_CODCFG = :CODCFG ');
        SQL.Add('   AND CFG_EMBALA = :EMBALA ');
        SQL.Add('   AND CFG_LINHA_ = :LINHA_ ');
        SQL.Add('   AND CFG_CODITE = :CODITE ');
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('IDEPRO').AsString := strIdeProEmb;
        ParamByName('CODCFG').AsString := strCodCfgEmb;
        ParamByName('EMBALA').AsString := strEmbalaEmb;
        ParamByName('LINHA_').AsString := strLinha_Emb;
        ParamByName('CODITE').AsString := cdsProdutosCODITE.AsString;;
        ExecSQL;
        cdsProdutos.Delete;        
        fCommit;
        blnGravou := Not cdsProdutos.IsEmpty;
        fMensagem('ATENÇÃO!', 'Item excluído com sucesso!', ['&O k']);
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível excluir o item selecionado!', ['&O k']);
      end;
    End;
  Finally

  End;                            
end;

procedure TfrmCadEmbTinta.pExcluirDaTabela;
begin
  If (Not cdsProdutos.IsEmpty) And (cdsProdutos.RecordCount > 0) Then
    pExcluir;
end;

procedure TfrmCadEmbTinta.pGravar;
var
  qryIns: TUniQuery;
begin
  Try
    qryIns := fCriaQuery(Nil);
    With cdsProdutos Do
    Begin
      First;
      While Not Eof Do
      Begin
        Try
          qryIns.Close;
          qryIns.SQL.Clear;
          qryIns.SQL.Add('INSERT INTO CFGEMB ( ');
          qryIns.SQL.Add(' CFG_CODEMP, ');
          qryIns.SQL.Add(' CFG_IDEPRO, ');
          qryIns.SQL.Add(' CFG_CODCFG, ');
          qryIns.SQL.Add(' CFG_EMBALA, ');
          qryIns.SQL.Add(' CFG_LINHA_, ');
          qryIns.SQL.Add(' CFG_CODITE, ');
          qryIns.SQL.Add(' CFG_PRINCI) ');
          qryIns.SQL.Add(' VALUES (    ');
          qryIns.SQL.Add(' :CODEMP,  ');
          qryIns.SQL.Add(' :IDEPRO,  ');
          qryIns.SQL.Add(' :CODCFG,  ');
          qryIns.SQL.Add(' :EMBALA,  ');
          qryIns.SQL.Add(' :LINHA_,  ');
          qryIns.SQL.Add(' :CODITE,  ');
          qryIns.SQL.Add(' :PRINCI)  ');

          qryIns.ParamByName('CODEMP').AsString := VS_strCodEmp;
          qryIns.ParamByName('IDEPRO').AsString := strIdeProEmb;
          qryIns.ParamByName('CODCFG').AsString := strCodCfgEmb;
          qryIns.ParamByName('EMBALA').AsString := strEmbalaEmb;
          qryIns.ParamByName('LINHA_').AsString := strLinha_Emb;
          qryIns.ParamByName('CODITE').AsString := FieldByName('CODITE').AsString;
          qryIns.ParamByName('PRINCI').AsString := FieldByName('PRINCI').AsString;
          qryIns.ExecSQL;
          fCommit;
        Except
          On E: EUniError Do
          Begin
            If E.ErrorCode <> ERROR_PRIMARY_KEY_INSERT  Then
              Raise;
          End;
        End;
        Next;
      End;
      fMensagem('Informação!','Registros gravados com sucesso!',['&Ok'])
    End;
  Finally
    FreeAndNil(qryIns);
  End;
end;

procedure TfrmCadEmbTinta.pGravarNaTabela;
begin
  If Not cdsProdutos.IsEmpty Then
  Begin
    pGravar;
    btnConfirma.Enabled := False;
    blnGravou := True;
    cxgEmbala.Enabled := True;
  End
  Else
    fMensagem('ATENÇÃO','É obrigatório o preenchimento da embalagem!',['&OK']);  
end;

procedure TfrmCadEmbTinta.pLimparTela;
begin
  edtProduto.Clear;
  edtDesProduto.Clear;
  pSetFocus(edtProduto);
end;

procedure TfrmCadEmbTinta.pMarcaItemPrincipal;
var
  strPrinc: String;
begin
  strPrinc := cdsProdutosCODITE.AsString;

  Try
    cdsProdutos.DisableControls;

    cdsProdutos.First;
    While Not cdsProdutos.Eof Do
    Begin
      cdsProdutos.Edit;
      cdsProdutosPRINCI.AsString := 'N';
      cdsProdutos.Post;

      If cdsProdutos.RecordCount > 1 Then
        pUpdateItemPrincipal(cdsProdutosCODITE.AsString,'N');

      cdsProdutos.Next;
    End;

    cdsProdutos.Locate('CODITE',strPrinc,[]);
    cdsProdutos.Edit;
    cdsProdutosPRINCI.AsString := 'S';
    cdsProdutos.Post;
    
    If cdsProdutos.RecordCount > 1 Then
      pUpdateItemPrincipal(cdsProdutosCODITE.AsString,'S');

  Finally
    cdsProdutos.EnableControls;
  End;
end;

procedure TfrmCadEmbTinta.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDesProduto';
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmCadEmbTinta.pSetaParametros(strCodCfg, strIdePro, strEmbala,
  strLinha_: String);
begin
  strCodCfgEmb := strCodCfg;
  strIdeProEmb := strIdePro;
  strEmbalaEmb := strEmbala;
  strLinha_Emb := strLinha_;
end;

procedure TfrmCadEmbTinta.pUpdateItemPrincipal(strCodIte, strValor: String);
var
  qryUpd: TUniQuery;
begin
  Try
    Try
      qryUpd := fCriaQuery(Nil);
      With qryUpd Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add(' UPDATE CFGEMB ');
        SQL.Add('    SET CFG_PRINCI = :PRINCI ');
        SQL.Add('  WHERE CFG_CODEMP = :CODEMP ');
        SQL.Add('    AND CFG_IDEPRO = :IDEPRO ');
        SQL.Add('    AND CFG_CODCFG = :CODCFG ');
        SQL.Add('    AND CFG_EMBALA = :EMBALA ');
        SQL.Add('    AND CFG_LINHA_ = :LINHA_ ');
        SQL.Add('    AND CFG_CODITE = :CODITE ');
        ParamByName('PRINCI').AsString := strValor;
        ParamByName('CODEMP').AsString := VS_strCodEmp;
        ParamByName('IDEPRO').AsString := strIdeProEmb;
        ParamByName('CODCFG').AsString := strCodCfgEmb;
        ParamByName('EMBALA').AsString := strEmbalaEmb;
        ParamByName('LINHA_').AsString := strLinha_Emb;
        ParamByName('CODITE').AsString := strCodIte;
        ExecSQL;
        If strValor = 'S' Then
          fMensagem('ATENÇÃO!','Item principal atualizado com sucesso!',['&O K']);
      End;
    Except
      on E: Exception do
      begin
        fMensagem('ATENÇÃO!', 'Não foi possível atualizar item principal!', ['&O k']);
      end;
    End;
  Finally
    FreeAndNil(qryUpd);
  End;
end;

end.

