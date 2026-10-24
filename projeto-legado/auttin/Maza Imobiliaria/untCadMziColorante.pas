{*****************************************}
{* frmModuloCons.qryCon001 -> CADUNI     *}
{**************************************MV*}
unit untCadMziColorante;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms,
  Dialogs, StdCtrls, untPaiCad, Menus, ComCtrls, Buttons, ExtCtrls,Uni,
  Mask, DBCtrls, DBEditFocus, EditFocus, AppEvnts, UniClientDataSet, DB,
  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadMziColorantes = class(TfrmPaiCad)
    Label1: TLabel;
    dbeCodCol: TDBEditFocus;
    Label2: TLabel;
    dbePreCus: TDBEditFocus;
    Label3: TLabel;
    dbeMargem: TDBEditFocus;
    Label4: TLabel;
    dbePreVen: TDBEditFocus;
    pnlFundo: TPanel;
    pnlCabecalho: TPanel;
    Label8: TLabel;
    edtDesIte: TEditFocus;
    dbeCodIte: TDBEditFocus;
    dtsMziCadCol: TDataSource;
    dbeEmbalagem: TDBEditFocus;
    Label5: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeCodIteExit(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
  private
    { Private declarations }
    dbeCodEmp: TDBEdit;
    qryCadIte: TUniQuery;
    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pCarregaItem;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    procedure pAtualizarFatorTintometrico;
  end;

var
  frmCadMziColorantes: TfrmCadMziColorantes;

implementation

uses untModuloTinta,  untPai, untPesqAux,
  untFuncoesSimples, untFuncTinta,
  untTypesSistema, untConsultas;

{$R *.dfm}

procedure TfrmCadMziColorantes.FormCreate(Sender: TObject);
begin
  inherited;
  qryTabela     := frmModuloTinta.qryMzi_CadCol;
  strNomeTabela := 'MZI_CADCOL';
  strNomeCampo  := 'COL_CODCOL';

  dtsMziCadCol.DataSet := frmModuloTinta.qryMzi_CadCol;

  TFloatField(dtsMziCadCol.DataSet.FieldByName('COL_PRECUS')).DisplayFormat := '#,##0.00';
  TFloatField(dtsMziCadCol.DataSet.FieldByName('COL_PREVEN')).DisplayFormat := '#,##0.00';

  {*****************************************}
  {* CRIA O CAMPO EMPRESA PARA SER USADO   *}
  {* NA FUNÇÃO DE BUSCA PARA ALTERAÇÃO     *}
  {**************************************MV*}
  dbeCodEmp            := TDBEdit.Create(Self);
  dbeCodEmp.DataField  := 'COL_CODEMP';
  dbeCodEmp.DataSource := frmModuloTinta.dtsMzi_CadCol;

  SetLength(arrCamposChave, 2);
  arrCamposChave[0] := dbeCodCol;
  arrCamposChave[1] := dbeCodEmp;

  qryCadIte := fCriarQuery('SELECT * FROM CADITE WHERE FALSE', Self);
end;

function TfrmCadMziColorantes.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,000';

  If fEmptyStr(dbeMargem.Text) Then
    dbeMargem.Text := '0,00';

  Result := fCalculaPrecoVenda(intOpcao,
                               fStrToFloat(dbePreCus.Text),
                               fStrToFloat(dbePreVen.Text),
                               fStrToFloat(dbeMargem.Text),
                               0.0,
                               0.0,
                               0.0,
                               0.0);
end;

function TfrmCadMziColorantes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = dbeCodCol) Then
    Begin

      If (fEmptyStr(dbeCodCol.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'O código deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (blnBuscaPorChave) Then
      Begin
        If (Not fBuscaPorCamposChave) Then
        Begin
          pLimparCampos;
        End;
      End;

    End
    Else
    If (Sender = dbeEmbalagem) Then
    Begin

      if fEmptyStr(dbeEmbalagem.text) Then
      Begin
        fMensagem('ATENÇÃO!', 'O campo embalagem deve ser preenchido!', ['&O k']);
        Result := False;
      end
      Else If (fStrToFloat(dbeEmbalagem.Text) <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'A embalagem deve ser maior que Zero!', ['&O k']);
        Result := False;
      end;
    End

    {*****************************************}
    {* VALIDA O ITEM COLORANTE               *}
    {**************************************MV*}
    Else If (Sender = dbeCodIte) Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fExisteValorNoCampo(dbeCodIte.Text, 'COL_CODITE', 'MZI_CADCOL', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado a outro colorante!'#10#13'Deseja continuar ?', ['Sim', 'Não'], 2) = 1;
        End
        Else
        Begin
          pCarregaItem;
          If (qryCadIte.FieldByName('ITE_CODITE').IsNull) Then
          Begin
            fMensagem('ATENÇÃO!', 'Esse item não está cadastrado!', ['&Ok']);
            Result := False;
          End;
        End;
      End;


    End

    Else If Not fEmptyStr(dbeCodIte.Text) Then
    Begin
      If (Sender = dbePreCus) Then
      Begin

        If (fEmptyStr(dbePreCus.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreCus.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de custo deve maior que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;

      End

      Else If (Sender = dbeMargem) Then
      Begin

        If (fEmptyStr(dbeMargem.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve ser preenchida!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbeMargem.Text) < 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'A margem deve maior ou igual a Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
        End;

      End

      Else If (Sender = dbePreVen) Then
      Begin

        If (fEmptyStr(dbePreVen.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda deve ser preenchido!', ['&O k']);
          Result := False;
        End
        Else If (fStrToFloat(dbePreVen.Text) <= 0) Then
        Begin
          fMensagem('ATENÇÃO!', 'O preço de venda que Zero!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
        End;

      End
    End;

  End;

  If (Not Result) Then
    pSetFocus(Sender);

end;

procedure TfrmCadMziColorantes.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('COL_CODCOL');
  stlCampos.Add('COL_PRECUS');
  stlCampos.Add('COL_MARGEM');
  stlCampos.Add('COL_PREVEN');
  stlCampos.Add('COL_EMBALA');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('COL_CODCOL');
  stlCamInd.Add('ITE_CODITE');
  stlCamInd.Add('ITE_DESITE+ITE_REFERE');

  stlDesInd.Add('Código do Colorante');
  stlDesInd.Add('Código do Item');
  stlDesInd.Add('Descrição do Item/Referência do Item');

end;

procedure TfrmCadMziColorantes.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  
  qryTabela.FieldByName('COL_CODEMP').AsString := VS_strCodEmp;
  pSetFocus(dbeCodCol);
  edtDesIte.Clear;
end;

procedure TfrmCadMziColorantes.btnAlterarClick(Sender: TObject);
begin
  inherited;
  dbeCodCol.Enabled := False;
  pSetFocus(dbePreCus);
end;

procedure TfrmCadMziColorantes.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
     SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadMziColorantes.pCarregaItem;
begin
  pPesquisaCadIte(qryCadIte, qryCadIte, dbeCodIte.Text);
  With qryCadIte Do
  Begin
    edtDesIte.Text := FieldByName('ITE_DESITE').AsString;
  End;
end;


procedure TfrmCadMziColorantes.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    Key: Char;
begin
  Key := '/';
  If fPesqColorantes(Self, conMzi, Nil, nil, qryTabela, Key, arrSel, True, '', '', False) Then
  Begin
    pCarregaItem;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadMziColorantes.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadMziColorantes.btnGravarClick(Sender: TObject);
begin
  fStartTransaction;
  inherited;

  Try
    If blnGravou Then
    Begin
      pAtualizarFatorTintometrico;
      fCommit;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[btnGravarClick]');
    End;
  End;
end;

procedure TfrmCadMziColorantes.dbeCodIteExit(Sender: TObject);
begin
  inherited;
  pCarregaItem;
end;

procedure TfrmCadMziColorantes.pAtualizarFatorTintometrico;
Var
  qryGen: TUniQuery;
begin
  qryGen := fCriaQuery(Self);
  qryGen.SQL.Text := 'UPDATE CADITE '+
                     ' INNER JOIN MZI_CADCOL ON ITE_CODITE = COL_CODITE '+
                     '   SET ITE_CNV_ML = :CNV_ML; ';

  qryGen.ParamByName('CNV_ML').AsFloat := dbeEmbalagem.Field.AsFloat;
  qryGen.ExecSQL;

  FreeAndNil(qryGen);
end;

end.

