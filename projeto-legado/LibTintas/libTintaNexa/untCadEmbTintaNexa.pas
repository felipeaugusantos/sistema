unit untCadEmbTintaNexa;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxCheckBox, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxControls, cxGridCustomView, cxGrid, EditFocus,
  untAutcomTintaFactory, untIDataSet,
  BitBtnLockedIncrem, cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, frxClass ,
  cxDataControllerConditionalFormattingRulesManagerDialog, Datasnap.DBClient,
  frxExportCSVTestabilidade, UniClientDataSet, Data.DB, Vcl.Grids,
  Vcl.DBGrids, Vcl.DBCtrls, DBGridCitel;

type
  TfrmCadEmbTintaNexa = class(TfrmPai)
    pnlGeral: TPanel;
    pnlProdutos: TPanel;
    grbProdutos: TGroupBox;
    Label1: TLabel;
    edtProduto: TEditFocus;
    edtDesProduto: TEditFocus;
    dtsProdutos: TDataSource;
    cdsProdutos: TUniClientDataSet;
    cdsProdutosCODITE: TStringField;
    cdsProdutosPRINCI: TStringField;
    cdsProdutosDESCRI: TStringField;
    btnConfirma: TBitBtnLocked;
    btnExcluir: TBitBtnLocked;
    btnAdicionar: TBitBtnLocked;
    btnCancelaItem: TBitBtnLocked;
    DBGrid1: TDBGridCitel;
    chkPrincipal: TCheckBox;
    BitBtnLocked1: TBitBtnLocked;
    procedure edtProdutoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnCancelaItemClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure cxgEmbalaViewPRINCIPropertiesChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsProdutosAfterScroll(DataSet: TDataSet);
    procedure chkPrincipalExit(Sender: TObject);
    procedure BitBtnLocked1Click(Sender: TObject);
  private
    { Private declarations }
    qryCadIte: IDataSet;
    strCodCfgEmb: String;
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

    function fValidarItemPrincipal : Boolean;


    function fRetNomProduto(Const strCodIte: String ): String;

    function fExisteEmbalagemPrincipal(strCodCfg : String) : Boolean;

  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pSetaParametros(strCodCfg, strEmbala, strLinha_: String);
  end;

var
  frmCadEmbTintaNexa: TfrmCadEmbTintaNexa;

implementation

uses
  untStrUtils;

{$R *.dfm}

procedure TfrmCadEmbTintaNexa.BitBtnLocked1Click(Sender: TObject);
begin
  inherited;
  edtProduto.Clear;
  edtDesProduto.Clear;


  TAutcomTintaFactory.Get.pSetFocus(edtProduto);

  chkPrincipal.Checked := False;
end;

procedure TfrmCadEmbTintaNexa.btnAdicionarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    pAdicinar;
    pLimparTela;
    // cxgEmbala.Enabled := False;
  End;
end;

function TfrmCadEmbTintaNexa.fRetNomProduto(Const strCodIte: String ): String;
Var
  qryGenIte: IDataSet;
Begin
  Result := '';

  If TStrUtils.fEmptyStr(strCodIte) Then
    Exit;


  qryGenIte := TAutcomTintaFactory.Get.fGetDataSet;
  qryGenIte.Close;
  qryGenIte.SQL := ' SELECT SQL_NO_CACHE '+
                   '   ITE_DESITE '+
                   ' FROM '+
                   '   CADITE '+
                   ' WHERE '+
                   '   ITE_CODITE = :CODITE ';

  qryGenIte.ParamByName('CODITE').AsString := strCodIte;
  qryGenIte.Open;

  Result := qryGenIte.FieldByName('ITE_DESITE').AsString
End;

procedure TfrmCadEmbTintaNexa.btnCancelaItemClick(Sender: TObject);
begin
  inherited;
  pLimparTela;
end;

procedure TfrmCadEmbTintaNexa.btnConfirmaClick(Sender: TObject);
begin

  If Not fValidarItemPrincipal then
  begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'É permitido cadastrar apenas uma embalagem como item principal!', ['&Ok']);
    exit;
  end;

  inherited;
  pGravarNaTabela;
end;

procedure TfrmCadEmbTintaNexa.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pExcluirDaTabela;
  TAutcomTintaFactory.Get.pSetFocus(edtProduto);
end;

procedure TfrmCadEmbTintaNexa.cdsProdutosAfterScroll(DataSet: TDataSet);
begin
  inherited;

  If TStrUtils.fEmptyStr(cdsProdutos.FieldByName('CODITE').AsString) Then
    Exit;

  chkPrincipal.Checked := (cdsProdutos.FieldByName('PRINCI').AsString = 'S');
  edtProduto.Text      := cdsProdutos.FieldByName('CODITE').AsString;
  edtDesProduto.Text   := cdsProdutos.FieldByName('DESCRI').AsString;
end;

procedure TfrmCadEmbTintaNexa.chkPrincipalExit(Sender: TObject);
Var
  strCodIte : String;
  blnMarcado: Boolean;
begin
  inherited;

  strCodIte  := edtProduto.Text;
  blnMarcado := chkPrincipal.Checked;

  If Not cdsProdutos.Locate('CODITE',strCodIte, []) Then
    cdsProdutos.Append
  else
    cdsProdutos.Edit;

  cdsProdutos.FieldByName('CODITE').AsString := edtProduto.Text;
  cdsProdutos.FieldByName('DESCRI').AsString := edtDesProduto.Text;
  cdsProdutos.FieldByName('PRINCI').AsString := TAutcomTintaFactory.Get.IIF(blnMarcado, 'S','N');
  cdsProdutos.Post;

  btnConfirma.Enabled := true;
end;

procedure TfrmCadEmbTintaNexa.cxgEmbalaViewPRINCIPropertiesChange(Sender: TObject);
begin
  inherited;
  pAtualizaItemPrincipal;
end;

procedure TfrmCadEmbTintaNexa.edtProdutoKeyPress(Sender: TObject; var Key: Char);
  Var
    edtDesEdt: TEdit;
begin
  inherited;
  If (TAutcomTintaFactory.Get.fEntraCons(Key)) Then
  Begin
    edtDesEdt := TEdit(FindComponent('edtDesProduto'));
    pConsultaItem(TEdit(Sender), edtDesEdt);
  End;
end;

function TfrmCadEmbTintaNexa.fExisteEmbalagemPrincipal(strCodCfg: String): Boolean;
Var
  qryCon: IDataSet;
begin

  qryCon := TAutcomTintaFactory.Get.fGetDataSet;
  qryCon.SQL := ' SELECT * ' +
                '   FROM CFGEMB '+
                '  WHERE CFG_CODEMP = :CODEMP '+
                '    AND CFG_CODCFG = :CODCFG '+
                '    AND CFG_IDEPRO = "NEX"   '+
                '    AND CFG_PRINCI = "S"     ';
  qryCon.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryCon.ParamByName('CODCFG').AsString := strCodCfg;
  qryCon.Open;

  Result := Not(qryCon.IsEmpty);
end;

procedure TfrmCadEmbTintaNexa.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  If cdsProdutos.IsEmpty Then
    exit;

  If fExisteEmbalagemPrincipal(strCodCfgEmb) Then
    inherited
  else
  begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'É obrigatório possuir uma embalagem como item principal!', ['&Ok']);
    Abort;
  end;
end;

procedure TfrmCadEmbTintaNexa.FormCreate(Sender: TObject);
begin
  inherited;
  qryCadIte := TAutcomTintaFactory.Get.fGetDataSet;
  cdsProdutos.CreateDataSet;

  TAutcomTintaFactory.Get.pSetaCodIte(cdsProdutosCODITE);
  TAutcomTintaFactory.Get.pSetaCodIte(edtProduto);
end;

procedure TfrmCadEmbTintaNexa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  Case Key Of
    VK_F10:btnConfirma.Click;
    VK_F9 :btnExcluir.Click;
  End;
end;

procedure TfrmCadEmbTintaNexa.FormShow(Sender: TObject);
begin
  inherited;
  pConsultaEmbalagem;
  TAutcomTintaFactory.Get.pSetFocus(edtProduto);
  cdsProdutos.First;
end;

function TfrmCadEmbTintaNexa.fValidaCampos(Sender: TWinControl;  blnBuscaPorChave: Boolean): Boolean;
  Var
    edtDesIte: TEdit;
begin

  Result := True;

  If (Sender = edtProduto) Then
  Begin
    If (TStrUtils.fEmptyStr(edtProduto.Text)) Then
    Begin
      TAutcomTintaFactory.Get.fMensagem('AVISO', 'Todos os itens devem ser preenchidos!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      pRetornaDescricaoItem(edtProduto);
      edtDesIte := TEdit(FindComponent('edtDesProduto'));

      If (TStrUtils.fEmptyStr(edtDesIte.Text)) Then
      Begin
        TAutcomTintaFactory.Get.fMensagem('AVISO', 'Esse item não está cadastrado!', ['&Ok']);
        Result := False;
      End;
    End;

  End;
end;

function TfrmCadEmbTintaNexa.fValidarItemPrincipal: Boolean;
Var
  strValor : String;
begin
  Result := true;

  cdsProdutos.First;

  strValor := '';

  While not cdsProdutos.Eof Do
  Begin
    If cdsProdutos.FieldByName('PRINCI').AsString =  'S' Then
    begin
      If strValor = '' Then
        strValor := 'S'
      else
      begin
        Result := false;
        break;
      end;
    end;

    cdsProdutos.Next;
  End;


end;

procedure TfrmCadEmbTintaNexa.pAdicinar;
begin
  If cdsProdutos.Locate('CODITE', edtProduto.Text,[]) Then
  begin
    TAutcomTintaFactory.Get.fMensagem('AVISO', 'Esse item já está cadastrado!', ['&Ok']);
    exit;
  end;

  cdsProdutos.Append;
  cdsProdutos.FieldByName('CODITE').AsString := edtProduto.Text;
  cdsProdutos.FieldByName('DESCRI').AsString := edtDesProduto.Text;
  cdsProdutos.FieldByName('PRINCI').AsString := TAutcomTintaFactory.Get.IIF(cdsProdutos.RecordCount = 0,'S','N');
  cdsProdutos.Post;

  cdsProdutos.Close;
  cdsProdutos.Open;

  btnConfirma.Enabled := True;
end;

procedure TfrmCadEmbTintaNexa.pAtualizaItemPrincipal;
begin
  pMarcaItemPrincipal
end;

procedure TfrmCadEmbTintaNexa.pConsultaEmbalagem;
var
  qryCon: IDataSet;
begin
  Try

    Try
      qryCon := TAutcomTintaFactory.Get.fGetDataSet;
      qryCon.SQL := ' SELECT CFG_CODITE, CFG_PRINCI ' +
                    '   FROM CFGEMB '+
                    '  WHERE CFG_CODEMP = :CODEMP '+
                    '    AND CFG_CODCFG = :CODCFG '+
                    '    AND CFG_IDEPRO = "NEX"   ';
      qryCon.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
      qryCon.ParamByName('CODCFG').AsString := strCodCfgEmb;
      qryCon.Open;

      If Not qryCon.IsEmpty Then
      Begin
        qryCon.First;

        While Not qryCon.Eof Do
        Begin
          cdsProdutos.Append;
          cdsProdutosCODITE.AsString := qryCon.FieldByName('CFG_CODITE').AsString;
          cdsProdutosDESCRI.AsString := fRetNomProduto(qryCon.FieldByName('CFG_CODITE').AsString);
          cdsProdutosPRINCI.AsString := qryCon.FieldByName('CFG_PRINCI').AsString;
          cdsProdutos.Post;

          qryCon.Next;
        End;

      End;

    Except

    End;

  Finally

  End;
end;

procedure TfrmCadEmbTintaNexa.pConsultaItem(edtItem, edtDesIte: TEdit);
var
  strSQL, strSQLWhere: String;
  qryCadIte : IDataSet;

  arrTitCol: array of string;

  Procedure pAddNomeColuna(strNomCol: String);
  Begin
    SetLength(arrTitCol, Succ(Length(arrTitCol)));
    arrTitCol[High(arrTitCol)] := strNomCol;
  End;

begin
  qryCadIte := Nil;

  strSQL := 'SELECT';
  strSQL := strSQL + '    CADITE.ITE_DESITE, ';  pAddNomeColuna('Descrição');
  strSQL := strSQL + '    CADITE.ITE_REFERE, ';  pAddNomeColuna('Referência');
  strSQL := strSQL + '    CADITE.ITE_CODITE, ';  pAddNomeColuna('Código');
  strSQL := strSQL + '    CADITE.ITE_CODBAR, ';  pAddNomeColuna('Cód. Barra');
  strSQL := strSQL + '    CADITE.AUTOINCREM  ';
  strSQL := strSQL + '  FROM CADITE ';
  strSQL := strSQL + ' INNER JOIN ITEGER ON CADITE.ITE_CODITE = ITEGER.ITE_CODITE ';
  strSQL := strSQL + '                  AND  ITE_IMPLIS = "S" ';

  strSQLWhere := strSQLWhere + ' WHERE ITE_ITEATI = "S" '+
                               '   AND ITE_PROEMB =  "S" ';

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITESER')) Then
      strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITESER'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('SERTER')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('SERTER'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEFRE'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEBOM'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEENE'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITEVID'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITETAX'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('PROMAT'));

  If Not TStrUtils.fEmptyStr(TAutcomTintaFactory.Get.fCfgSis('ITECON')) Then
    strSQLWhere := strSQLWhere + '  AND CADITE.ITE_CODITE <> ' + QuotedStr(TAutcomTintaFactory.Get.fCfgSis('ITECON'));

  strSQLWhere := strSQLWhere + '  AND CADITE.ITE_DESITE NOT LIKE "%ITEM ESPECIAL%"           ';

  If TAutcomTintaFactory.Get.pConsultaComp([strSQL, strSQLWhere], arrTitCol, ['ITE_DESITE'], 'AUTOINCREM',
                                           'CADITE', 'untCadEmbTintaNexa', 'Consulta Item - NEX', qryCadIte, [], []) Then
  Begin
      TEdit(edtItem).Text   := qryCadIte.FieldByName('ITE_CODITE').AsString;
      TEdit(edtDesIte).Text := qryCadIte.FieldByName('ITE_DESITE').AsString;
  End;

end;

procedure TfrmCadEmbTintaNexa.pExcluir;
var
  qryDel: IDataSet;
begin

  Try
    qryDel := TAutcomTintaFactory.Get.fGetDataSet;

    qryDel.SQL := ' DELETE '+
                  '   FROM CFGEMB '+
                  '  WHERE CFG_CODEMP = :CODEMP '+
                  '    AND CFG_IDEPRO = "NEX"   '+
                  '    AND CFG_CODCFG = :CODCFG '+
                  '    AND CFG_CODITE = :CODITE ';

    qryDel.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryDel.ParamByName('CODCFG').AsString := strCodCfgEmb;
    qryDel.ParamByName('CODITE').AsString := cdsProdutosCODITE.AsString;;

    qryDel.ExecSQL;

    cdsProdutos.Delete;

    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Item excluído com sucesso!', ['&O k']);
  Except
    on E: Exception do
    begin
      TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Não foi possível excluir o item selecionado!', ['&O k']);
    end;
  End;
end;

procedure TfrmCadEmbTintaNexa.pExcluirDaTabela;
begin
  If (Not cdsProdutos.IsEmpty) And (cdsProdutos.RecordCount > 0) Then
    pExcluir;
end;

procedure TfrmCadEmbTintaNexa.pGravar;
Var
  qryIns: IDataSet;
  qryDel : IDataSet;
begin


  qryDel := TAutcomTintaFactory.Get.fGetDataSet;

  qryDel.SQL := 'DELETE ' +
                '  FROM CFGEMB ' +
                ' WHERE CFG_CODEMP = :CODEMP ' +
                '   AND CFG_IDEPRO = :IDEPRO ' +
                '   AND CFG_CODCFG = :CODCFG ' ;
  qryDel.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
  qryDel.ParamByName('IDEPRO').AsString := 'NEX';
  qryDel.ParamByName('CODCFG').AsString := strCodCfgEmb;
  qryDel.ExecSQL;

  qryIns := TAutcomTintaFactory.Get.fGetDataSet;

  cdsProdutos.First;

  While Not cdsProdutos.Eof Do
  Begin
    qryIns.SQL := 'INSERT '+
                   '  INTO CFGEMB ( CFG_CODEMP, '+
                   '                CFG_IDEPRO, '+
                   '                CFG_CODCFG, '+
                   '                CFG_EMBALA, '+
                   '                CFG_LINHA_, '+
                   '                CFG_CODITE, '+
                   '                CFG_PRINCI) '+
                   '       VALUES ( :CODEMP,    '+
                   '                :IDEPRO,    '+
                   '                :CODCFG,    '+
                   '                :EMBALA,    '+
                   '                :LINHA_,    '+
                   '                :CODITE,    '+
                   '                :PRINCI)    ';

    qryIns.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;
    qryIns.ParamByName('IDEPRO').AsString := 'NEX';
    qryIns.ParamByName('CODCFG').AsString := strCodCfgEmb;
    qryIns.ParamByName('EMBALA').AsString := strEmbalaEmb;
    qryIns.ParamByName('LINHA_').AsString := strLinha_Emb;
    qryIns.ParamByName('CODITE').AsString := cdsProdutos.FieldByName('CODITE').AsString;
    qryIns.ParamByName('PRINCI').AsString := cdsProdutos.FieldByName('PRINCI').AsString;
    qryIns.ExecSQL;

    cdsProdutos.Next;
  End;

end;

procedure TfrmCadEmbTintaNexa.pGravarNaTabela;
begin
  If Not cdsProdutos.IsEmpty Then
  Begin
    pGravar;
    btnConfirma.Enabled := False;
    blnGravou := True;
    // cxgEmbala.Enabled := True;
  End
  Else
    TAutcomTintaFactory.Get.fMensagem('ATENÇÃO','É obrigatório o preenchimento da embalagem!',['&OK']);
end;

procedure TfrmCadEmbTintaNexa.pLimparTela;
begin
  edtProduto.Clear;
  edtDesProduto.Clear;
  TAutcomTintaFactory.Get.pSetFocus(edtProduto);
end;

procedure TfrmCadEmbTintaNexa.pMarcaItemPrincipal;
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

procedure TfrmCadEmbTintaNexa.pRetornaDescricaoItem(edtCodIte: TEdit);
  Var
    strNomEdt: String;
    edtDesIte: TEdit;
begin
  strNomEdt := 'edtDesProduto';
  edtDesIte := TEdit(FindComponent(strNomEdt));
  edtDesIte.Text := fRetNomProduto(edtCodIte.Text);
end;

procedure TfrmCadEmbTintaNexa.pSetaParametros(strCodCfg, strEmbala, strLinha_: String);
begin
  strCodCfgEmb := strCodCfg;
  strEmbalaEmb := strEmbala;
  strLinha_Emb := strLinha_;
end;

procedure TfrmCadEmbTintaNexa.pUpdateItemPrincipal(strCodIte, strValor: String);
var
  qryUpd: IDataSet;
begin

  Try
    Try
      qryUpd := TAutcomTintaFactory.Get.fGetDataSet;
      qryUpd.SQL := ' UPDATE CFGEMB '+
                    '    SET CFG_PRINCI = :PRINCI '+
                    '  WHERE CFG_CODEMP = :CODEMP '+
                    '    AND CFG_IDEPRO = "NEX"   '+
                    '    AND CFG_CODCFG = :CODCFG '+
                    '    AND CFG_EMBALA = :EMBALA '+
                    '    AND CFG_LINHA_ = :LINHA_ '+
                    '    AND CFG_CODITE = :CODITE ';
      qryUpd.ParamByName('PRINCI').AsString := strValor;
      qryUpd.ParamByName('CODEMP').AsString := TAutcomTintaFactory.Get.GetCodEmp;;
      qryUpd.ParamByName('CODCFG').AsString := strCodCfgEmb;
      qryUpd.ParamByName('EMBALA').AsString := strEmbalaEmb;
      qryUpd.ParamByName('LINHA_').AsString := strLinha_Emb;
      qryUpd.ParamByName('CODITE').AsString := strCodIte;
      qryUpd.ExecSQL;

      If strValor = 'S' Then
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!','Item principal atualizado com sucesso!',['&O K']);

    Except
      on E: Exception do
      begin
        TAutcomTintaFactory.Get.fMensagem('ATENÇÃO!', 'Não foi possível atualizar item principal!', ['&O k']);
      end;
    End;
  Finally
  End;
end;

end.

