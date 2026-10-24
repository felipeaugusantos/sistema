unit untCadAdtBases;

interface

uses
  SysUtils, Variants, Classes, Controls, Forms,
  untPaiCad, StdCtrls, Buttons,
  ExtCtrls, Mask, DBCtrls, DBEditFocus, EditFocus, Uni, DB,
  BitBtnLockedIncrem, AppEvnts, Menus, ComCtrls, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmCadAdtBases = class(TfrmPaiCad)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    btnRestPreco: TSpeedButton;
    pnlCabecalho: TPanel;
    edtDesIte: TEditFocus;
    dbeCodigo: TDBEditFocus;
    dbeDescricao: TDBEditFocus;
    dbeCodIte: TDBEditFocus;
    dbePreCus: TDBEditFocus;
    dbeMargem: TDBEditFocus;
    dbePreVen: TDBEditFocus;
    Label3: TLabel;
    dbeUnidade: TDBEditFocus;
    edtUnidade: TEditFocus;
    edtCodUni: TEditFocus;
    Label4: TLabel;
    dbePesEsp: TDBEditFocus;
    lblProduto: TLabel;
    dbeProduto: TDBEditFocus;
    lblConteudo: TLabel;
    dbeConteudo: TDBEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure dbeUnidadeExit(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure dbeUnidadeKeyPress(Sender: TObject; var Key: Char);
    procedure dbeCodIteKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnRestPrecoClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    qryCadBas: TUniQuery;
    dtsCadBas: TDataSource;
    procedure pCriaDataSets;
    procedure pLigaDataSets;

    procedure pCarregaUnidade;
    procedure pCarregaItem;

    function fRetPrecoVenda(intOpcao: Integer): Double;
    procedure pbtnRestaura;
  public
    { Public declarations }
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmCadAdtBases: TfrmCadAdtBases;

implementation

uses untFuncoesSimples, untFuncTinta, untConsultas, untTypesSistema;

{$R *.dfm}

{ TfrmCadAdvTintoSystem }

function TfrmCadAdtBases.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If Sender = dbeCodigo Then
    Begin
      If fEmptyStr(dbeCodigo.Text) Then
        Result := (fMensagem('ATENÇÃO', 'O código da base deve ser informado!', ['OK']) = -1)
    End

    Else If Sender = dbeDescricao Then
    Begin
      If fEmptyStr(dbeDescricao.Text) Then
        Result := (fMensagem('ATENÇÃO', 'A descrição da base deve ser informada!', ['OK']) = -1);
    End

    Else If Sender = dbeUnidade Then
    Begin
      pCarregaUnidade;

      If fEmptyStr(dbeUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A embalagem deve ser preenchida!', ['OK']) = -1;
      End

      Else If fEmptyStr(edtUnidade.Text) Then
      Begin
        Result := fMensagem('ATENÇÃO', 'A embalagem não é válida!', ['OK']) = -1;
      End;
    End

//    Else If Not fEmptyStr(dbeCodIte.Text) Then
//    Begin
    Else If Sender = dbeCodIte Then
    Begin
      pCarregaItem;
      if not fEmptyStr(dbeCodIte.Text) then
      begin
        if fEmptyStr(fGetDescricaoProdutoTinta(dbeCodIte.Text)) then
        begin
          fMensagem('ATENÇÃO', Format('O produto %s não está cadastrado', [dbeCodIte.Text]), ['&OK']);
          Result := False;
        end
        Else If Not fItemAtivo(dbeCodIte.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O item não está ativo', ['OK']) = -1;
        End
        Else If fExisteValorNoCampo(dbeCodIte.Text, 'BAS_CODITE', 'ADV_CADBAS', 'AUTOINCREM <> ' + QuotedStr(qryTabela.FieldByName('AUTOINCREM').AsString)) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'Esse item já está relacionado com outra base!'#10#13'Deseja Continuar?', ['Sim', 'Não']) = 1;
        End;
      end
      else
      begin
        dbeCodIte.Field.Value := Null;
        dbePreCus.Field.Value := 0;
        dbeMargem.Field.Value := 0;
        dbePreVen.Field.Value := 0;
      end;
    End
//    End
    Else If Sender = dbePreCus Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fEmptyStr(dbePreCus.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custos deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreCus.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de custo deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End;
    End

    Else If Sender = dbePreVen Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fEmptyStr(dbePreVen.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser preenchido!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbePreVen.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'O preço de venda deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbeMargem.Field.AsFloat := fRetPrecoVenda(2);
      End;
    End

    Else If Sender = dbeMargem Then
    Begin
      If Not fEmptyStr(dbeCodIte.Text) Then
      Begin
        If fEmptyStr(dbeMargem.Text) Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser preenchida!', ['OK']) = -1;
        End
        Else If fStrToFloat(dbeMargem.Text) <= 0 Then
        Begin
          Result := fMensagem('ATENÇÃO', 'A margem deve ser maior que zero!', ['OK']) = -1;
        End
        Else
          dbePreVen.Field.AsFloat := fRetPrecoVenda(1);
      End;
    End
    else if Sender = dbeConteudo then
    begin
      if fEmptyStr(dbeConteudo.Text) then
      begin
        fMensagem('ATENÇÃO!', 'O Conteúdo deve ser preenchido!', ['OK']);
        Result := False;
      end
      else if fStrToFloat(dbeConteudo.Text) <= 0 then
      begin
        fMensagem('ATENÇÃO!', 'O Conteúdo deve ser maior que zero!', ['OK']);
        Result := False;
      end;
    end; 
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadAdtBases.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('BAS_CODBAS');
  stlCampos.Add('BAS_PRODUT');
  stlCampos.Add('BAS_DESCRI');
  stlCampos.Add('UNI_SIGUNI');

  stlCamInd.Add('BAS_CODBAS');
  stlCamInd.Add('BAS_PRODUT');
  stlCamInd.Add('BAS_DESCRI');
  stlCamInd.Add('UNI_SIGUNI');

  stlDesInd.Add('Código da Base');
  stlDesInd.Add('Produto');
  stlDesInd.Add('Descrição');
end;

procedure TfrmCadAdtBases.FormCreate(Sender: TObject);
begin
  inherited;
  pCriaDataSets;
  pLigaDataSets;

  qryTabela := qryCadBas;
  strNomeTabela := 'ADT_CADBAS';
  strNomeCampo := 'BAS_CODBAS';

  SetLength(arrCamposChave, 3);
  arrCamposChave[0] := dbeCodigo;
  arrCamposChave[1] := dbeProduto;
  arrCamposChave[2] := dbeUnidade;
end;

procedure TfrmCadAdtBases.pCriaDataSets;
begin

  qryCadBas := fCriarQuery('SELECT * FROM ADT_CADBAS', Self);

  qryCadBas.FieldByName('BAS_CODBAS').DisplayLabel := 'Código da Base';
  qryCadBas.FieldByName('BAS_PRODUT').DisplayLabel := 'Produto';
  qryCadBas.FieldByName('BAS_DESCRI').DisplayLabel := 'Descrição';

  qryCadBas.FieldByName('AUTOINCREM').Visible := False;

  TFloatField(qryCadBas.FieldByName('BAS_PRECUS')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PREVEN')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_MARGEM')).DisplayFormat := '0.00';
  TFloatField(qryCadBas.FieldByName('BAS_PESESP')).DisplayFormat := '0.0000';

  dtsCadBas := fCriaDataSource(qryCadBas);
end;

procedure TfrmCadAdtBases.pLigaDataSets;
  Var
    intCont: Integer;
begin
  {***********************************************************}
  {* LIGA TODOS OS DBEDITS NO DATASOUCE CRIADO DINAMICAMENTE *}
  {********************************************************PH*}
  For intCont := 0 To ComponentCount - 1 Do
  Begin
    If (Components[intCont] is TDBEdit) Then
    Begin
      (Components[intCont] as TDBEdit).DataSource := dtsCadBas;
    End;
  End;
end;

procedure TfrmCadAdtBases.pCarregaUnidade;
  Var
    qryGen: TUniQuery;
begin
  qryGen := fCriaQuery();
  qryGen.SQL.Text :=
    ' SELECT                             ' +
    '   EMB_DESCRI                       ' +
    '   , UNI_SIGUNI                     ' +
    ' FROM                               ' +
    '   ADT_CADEMB E                     ' +
    '   INNER JOIN CADUNI U              ' +
    '     ON E.EMB_CODUNI = U.UNI_CODUNI ' +
    ' WHERE E.EMB_CODEMB = :CODEMB       ';
  qryGen.ParamByName('CODEMB').AsString := dbeUnidade.Text;
  qryGen.Open;
  edtUnidade.Text := qryGen.FieldByName('EMB_DESCRI').AsString;
  edtCodUni.Text := qryGen.FieldByName('UNI_SIGUNI').AsString;
end;

procedure TfrmCadAdtBases.dbeUnidadeExit(Sender: TObject);
begin
  inherited;
  pCarregaUnidade;
end;

procedure TfrmCadAdtBases.btnPesquisaClick(Sender: TObject);
  Var
    arrSel: TConsultasArray;
    key: Char;
begin
  Key := '/';
  If fPesqBaseTinta(Self, conAdt, Nil, nil, qryTabela, Key, arrSel, True, '', 'BAS_CODITE', False) Then
  Begin
    pCarregaItem;
    pCarregaUnidade;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAdtBases.pCarregaItem;
begin
  edtDesIte.Text := fGetDescricaoProdutoTinta(dbeCodIte.Text);
end;

procedure TfrmCadAdtBases.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
  pSetFocus(dbeCodigo);

end;

function TfrmCadAdtBases.fRetPrecoVenda(intOpcao: Integer): Double;
begin
  If fEmptyStr(dbePreVen.Text) Then
    dbePreVen.Text := '0,00';

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

procedure TfrmCadAdtBases.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;

  edtUnidade.Clear;
  edtCodUni.Clear;
  edtDesIte.Clear;


  pSetFocus(dbeCodigo);
end;

procedure TfrmCadAdtBases.dbeUnidadeKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel: TConsultasArray;
begin
  inherited;
  If fPesqEmbalagemUnidadeTinta(Self,  conAdt, dbeUnidade, Nil, Nil, '', Nil, Key, arrSel) Then
  Begin
    pCarregaUnidade;
    SelectNext(ActiveControl, True, True);
    fValidaCampos(dbeUnidade, True);
  End;
end;

procedure TfrmCadAdtBases.dbeCodIteKeyPress(Sender: TObject; var Key: Char);
  Var
    arrSel : TConsultasArray;
begin
  If fPesqItem(conIteSimples, Self, dbeCodIte, edtDesIte, nil, key, arrSel) Then
  Begin
    pCarregaItem;
    btnRestPreco.Click;
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmCadAdtBases.pbtnRestaura;
begin
  btnRestPreco.Visible := qryCadBas.State = dsEdit;
end;

procedure TfrmCadAdtBases.btnGravarClick(Sender: TObject);
var
  strDescr : String;
begin
  strDescr := dbeDescricao.text;

  strDescr := StringReplace(strDescr,'BASE','',[rfReplaceAll]);
  strDescr := StringReplace(strDescr,'PARTE B','',[rfReplaceAll]);

  If fMensagem('', 'Informe o tipo do cadastro: ', ['&Base', '&Catalisador']) = 1 Then
    dbeDescricao.text := ('BASE ' + Trim(strDescr))
  else
    dbeDescricao.text := (Trim(strDescr) + ' PARTE B');

  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdtBases.btnCancelaClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;
end;

procedure TfrmCadAdtBases.btnRestPrecoClick(Sender: TObject);
  Var
    fltPrecus: Double;
    fltMargem: Double;
    fltPreVen: Double;
begin
  inherited;
  pRetornaPrecos(dbeCodIte.Text, fltPrecus, fltMargem, fltPreVen);
  dbePreCus.Field.AsFloat := fltPrecus;
  dbeMargem.Field.AsFloat := fltMargem;
  dbePreVen.Field.AsFloat := fltPreVen;
end;

procedure TfrmCadAdtBases.btnExcluirClick(Sender: TObject);
begin
  inherited;
  pbtnRestaura;

  edtUnidade.Clear;
  edtCodUni.Clear;
  edtDesIte.Clear;

end;

end.

