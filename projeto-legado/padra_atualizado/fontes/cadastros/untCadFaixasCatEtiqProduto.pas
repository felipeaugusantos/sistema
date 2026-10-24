unit untCadFaixasCatEtiqProduto;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage,
  cxEdit, cxNavigator, cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, EditFocus, Uni, Vcl.Mask, Vcl.DBCtrls, DBEditFocus;

type
  TfrmCadFaixasCatEtiqProduto = class(TfrmPaiCad)
    pnlDados: TPanel;
    pnlFaixas: TPanel;
    Label12: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    dbeInicioFaixa: TDBEditFocus;
    dbeFinalFaixa: TDBEditFocus;
    dtsTabela: TDataSource;
    dbeCategoria: TDBEditFocus;

    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    function fCategoriaInicialFinalExiste(fltFaixa: Double): Boolean;

  public
    { Public declarations }
  protected
    { Protected declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;

  end;

implementation

{$R *.dfm}

Uses untFuncoesSimples, untTypesSistema, untConsultas;

{ TfrmCadFaixasCatEtiqProduto }

procedure TfrmCadFaixasCatEtiqProduto.pInicializaIndices;
begin
  inherited;

end;

procedure TfrmCadFaixasCatEtiqProduto.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCategoria);
end;

procedure TfrmCadFaixasCatEtiqProduto.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasCatEtiqProduto.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixasCatEtiqProduto.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[TfrmCadFaixasCatEtiqProduto.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadFaixasCatEtiqProduto.btnIncluirClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeCategoria);
end;

procedure TfrmCadFaixasCatEtiqProduto.btnPesquisaClick(Sender: TObject);
Var
  arrSel : TConsultasArray;
  Key    : Char;
Begin

  Key := '/';

  If fPesqCatEtiqProduto(Self, dbeCategoria, qryTabela, Key, arrSel) then
  Begin
    fValidaCampos(dbeCategoria, False);
    pSetFocus(btnAlterar);
  End;

End;

function TfrmCadFaixasCatEtiqProduto.fCategoriaInicialFinalExiste(fltFaixa: Double): Boolean;
  Var
    strSQL: String;
    qryGenTab: TUniQuery;
begin
  Try

    qryGenTab := fCriaQuery(Self);

    Result := False;

    strSQL := '';
    strSQL := strSQL + 'SELECT SQL_NO_CACHE * ';
    strSQL := strSQL + '  FROM FXACAT';
    strSQL := strSQL + ' WHERE :FAIXA BETWEEN CAT_INICIO AND CAT_FINAL';

    qryGenTab.Close;
    qryGenTab.SQL.Clear;
    qryGenTab.SQL.Add(strSQL);
    qryGenTab.ParamByName('FAIXA').asFloat := fltFaixa;
    qryGenTab.Open;

    If Not qryGenTab.IsEmpty Then
      result := true;

  Finally
    FreeAndNil(qryGenTab);
  End;

end;

procedure TfrmCadFaixasCatEtiqProduto.FormCreate(Sender: TObject);

begin

  inherited;

  strNomeTabela     := 'FXACAT';
  strNomeCampo      := 'AUTOINCREM';

  qryTabela := fCriarQuery('SELECT * FROM FXACAT WHERE FALSE', Self);
  dtsTabela.DataSet := qryTabela;

  TFloatField(qryTabela.FieldbyName('CAT_INICIO')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldbyName('CAT_INICIO')).EditFormat := '#,##0.00';
  TFloatField(qryTabela.FieldbyName('CAT_FINAL')).DisplayFormat := '#,##0.00';
  TFloatField(qryTabela.FieldbyName('CAT_FINAL')).EditFormat := '#,##0.00';

end;

function TfrmCadFaixasCatEtiqProduto.fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean) : Boolean;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeCategoria) Then
    Begin
      If fEmptyStr(dbeCategoria.Text) Then
      Begin
        fMensagem('', 'Categoria não informada!', ['&OK']);
        Result := False;
      End;
    End
    Else
    If (Sender = dbeInicioFaixa) Then
    Begin
      If fEmptyStr(dbeInicioFaixa.Text) Then
      Begin
        fMensagem('', '% Faixa Inicial não informada!', ['&OK']);
        Result := False;
      end
      else
      begin
        if StrToFloat(dbeInicioFaixa.Text) > 100 then
        begin
          fMensagem('', '% Faixa Inicial não pode ser maior que 100!', ['&OK']);
          Result := False;
        end;

        if (fCategoriaInicialFinalExiste(StrToFloat(dbeInicioFaixa.Text))) then
        begin
          fMensagem('', '% Faixa Inicial cadastrada já existe!', ['&OK']);
          Result := False;
        end;

      End;
    End
    Else
    If (Sender = dbeFinalFaixa) Then
    Begin

      If fEmptyStr(dbeFinalFaixa.Text) Then
      Begin
        fMensagem('', '% Faixa Final não informada!', ['&OK']);
        Result := False;
      end
      else
      begin
        if StrToFloat(dbeFinalFaixa.Text) > 100 then
        begin
          fMensagem('', '% Faixa Final não pode ser maior que 100!', ['&OK']);
          Result := False;
        end;

        if (fCategoriaInicialFinalExiste(StrToFloat(dbeFinalFaixa.Text))) then
        begin
          fMensagem('', '% Faixa Final cadastrada já existe!', ['&OK']);
          Result := False;
        end;

      End;
    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;


end.
