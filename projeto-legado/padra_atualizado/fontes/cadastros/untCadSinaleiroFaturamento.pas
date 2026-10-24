unit untCadSinaleiroFaturamento;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiCad, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.Mask, Vcl.DBCtrls,
  DBEditFocus, Data.DB, Vcl.Grids, Vcl.DBGrids, DBGridCitel, Datasnap.DBClient,
  UniClientDataSet, EditFocus, untTypesSistema, MemDS, DBAccess, Uni;

type
  TfrmCadSinaleiroFaturamento = class(TfrmPaiCad)
    tbsVendedores: TTabSheet;
    pnlCabecalho: TPanel;
    lblCodigo: TLabel;
    dbeCodFai: TDBEditFocus;
    lblDescricao: TLabel;
    dbeDesFai: TDBEditFocus;
    dbgFaixaDeMargem: TDBGridCitel;
    lblMarIni: TLabel;
    lblMarFin: TLabel;
    lblCorSinaleiro: TLabel;
    btnAdicionarFaixaDeMargem: TBitBtnLocked;
    cdsFAIPER: TUniClientDataSet;
    cdsFAIVEN: TUniClientDataSet;
    dscFAIPER: TDataSource;
    dscFAIVEN: TDataSource;
    cdsFAIPERAUTOINCREM: TStringField;
    cdsFAIPERFAI_CODFAI: TStringField;
    cdsFAIPERFAI_MARINI: TFloatField;
    cdsFAIPERFAI_MARFIN: TFloatField;
    cdsFAIPERFAI_CORFAI: TStringField;
    dbgVendedores: TDBGridCitel;
    btnAdicionarVendedores: TBitBtnLocked;
    lblVendedor: TLabel;
    edtCodVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtMarIni: TEditFocus;
    edtMarFin: TEditFocus;
    cdsFAIVENAUTOINCREM: TStringField;
    cdsFAIVENFAI_CODFAI: TStringField;
    cdsFAIVENFAI_CODVEN: TStringField;
    cdsFAIVENCODIGO_NOME: TStringField;
    cldCores: TColorDialog;
    edtCorSinaleiro: TEditFocus;
    dscFAIMAR: TDataSource;
    procedure FormCreate(Sender: TObject);
    procedure edtCodVenKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodVenExit(Sender: TObject);
    procedure lblCorSinaleiroClick(Sender: TObject);
    procedure edtCorSinaleiroChange(Sender: TObject);
    procedure btnAdicionarFaixaDeMargemClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure dbgFaixaDeMargemDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCorSinaleiroClick(Sender: TObject);
    procedure dbgFaixaDeMargemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnAdicionarVendedoresClick(Sender: TObject);
    procedure dbgVendedoresKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function fValidouAbaFaixaDeMargem : Boolean;
    function fValidouAbaVendedores : Boolean;

    procedure pLimparAbaFaixaDeMargem;
    procedure pLimparAbaVendedores;
    procedure pCarregarAbas;

    procedure pProcessarDeletados;

    function fValidarFaixasConflitantes : Boolean;
    function fValidarFaixaSemVendedores : Boolean;
    function fValidarFaixaComVendedores : Boolean;

    function fValidarFaixas(fltIni, fltFin, fltIni_, fltFin_ : Double) : Boolean;
    function fValorDentroFaixa(fltValor, fltFaixaIni, fltFaixaFin : Double) : Boolean;

    function fPodeGravar : Boolean;

  protected

    arrVendedor : TConsultasArray;

    procedure pInicializaIndices; override;
    function fValidaCampos(Sender : TWinControl; blnBuscaPorChave : Boolean):Boolean; Override;
    procedure pNewRecord(DataSet : TDataSet);
  public
    { Public declarations }
  end;

implementation

uses
  untFuncoesSimples, untConsultas, untFuncoesConsulta;

{$R *.dfm}

procedure TfrmCadSinaleiroFaturamento.btnAdicionarFaixaDeMargemClick(Sender: TObject);
begin

  inherited;

  If Not fValidouAbaFaixaDeMargem Then
    Exit;

  cdsFAIPER.Append;
  cdsFAIPERAUTOINCREM.AsString := '';
  cdsFAIPERFAI_CODFAI.AsString := '';
  cdsFAIPERFAI_MARINI.AsFloat  := fStrToFloat(edtMarIni.Text);
  cdsFAIPERFAI_MARFIN.AsFloat  := fStrToFloat(edtMarFin.Text);
  cdsFAIPERFAI_CORFAI.AsString := edtCorSinaleiro.Text;
  cdsFAIPER.Post;

  pLimparAbaFaixaDeMargem;
  pSetFocus(edtMarIni);

end;

procedure TfrmCadSinaleiroFaturamento.btnAdicionarVendedoresClick(Sender: TObject);
begin

  inherited;

  If Not fValidouAbaVendedores Then
    Exit;

  cdsFAIVEN.Append;
  cdsFAIVENAUTOINCREM.AsString  := '';
  cdsFAIVENFAI_CODFAI.AsString  := '';
  cdsFAIVENFAI_CODVEN.AsString  := edtCodVen.Text;
  cdsFAIVENCODIGO_NOME.AsString := edtCodVen.Text + ' - ' + edtNomVen.Text;
  cdsFAIVEN.Post;

  pLimparAbaVendedores;
  pSetFocus(edtCodVen);

end;

procedure TfrmCadSinaleiroFaturamento.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pHabilitaCodigo(dbeCodFai, dbeDesFai, False);
  if dbeDesFai.Enabled then
  Begin
    dbgFaixaDeMargem.Enabled := True;
    dbgVendedores.Enabled    := True;
  End;
end;

procedure TfrmCadSinaleiroFaturamento.btnCancelaClick(Sender: TObject);
begin

  inherited;

  cdsFAIPER.EmptyDataSet;
  cdsFAIVEN.EmptyDataSet;

  If Not fEmptyStr(dbeCodFai.Text) Then
    pCarregarAbas;

  dbgFaixaDeMargem.Enabled := False;
  dbgVendedores.Enabled    := False;

  pLimparAbaFaixaDeMargem;
  pLimparAbaVendedores;

end;

procedure TfrmCadSinaleiroFaturamento.btnExcluirClick(Sender: TObject);
var
  qryAux    : TUniQuery;
  strCodFai : String;
begin

  strCodFai := dbeCodFai.Text;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;

    If (blnExcluiu) Then
    Begin
      qryAux := fCriaQuery;
      Try
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('DELETE FROM FAIPER WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
        qryAux.ExecSQL;

        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add('DELETE FROM FAIVEN WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
        qryAux.ExecSQL;

      Finally
        FreeAndNil(qryAux);
      End;
      fCommit;

      cdsFAIPER.EmptyDataSet;
      cdsFAIVEN.EmptyDataSet;

      pLimparAbaFaixaDeMargem;
      pLimparAbaVendedores;

      If Not fEmptyStr(dbeCodFai.Text) Then
        pCarregarAbas;
    End
    Else
      fRollBack;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadSinaleiroFaturamento.btnExcluirClick]');
    End;
  End;

end;

procedure TfrmCadSinaleiroFaturamento.btnGravarClick(Sender: TObject);
var
  qryAux : TUniQuery;
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  If Not fPodeGravar Then
    Exit;


  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    //Grava FAIMAR
    inherited;

    If (blnGravou) Then
    Begin

      //Grava FAIPER
      If Not cdsFAIPER.IsEmpty Then
      Begin

        Try

          qryAux := fCriaQuery;

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('SELECT * FROM FAIPER WHERE FALSE');
          qryAux.Open;

          cdsFAIPER.First;
          While Not cdsFAIPER.Eof Do
          Begin

            If fEmptyStr(cdsFAIPERAUTOINCREM.AsString) Then
            Begin
              qryAux.Append;
              qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAIPER', VS_strCodEmp);
              qryAux.FieldByName('FAI_CODFAI').AsString := dbeCodFai.Text;
              qryAux.FieldByName('FAI_MARINI').AsFloat  := cdsFAIPERFAI_MARINI.AsFloat;
              qryAux.FieldByName('FAI_MARFIN').AsFloat  := cdsFAIPERFAI_MARFIN.AsFloat;
              qryAux.FieldByName('FAI_CORFAI').AsString := cdsFAIPERFAI_CORFAI.AsString;
              qryAux.Post;

              cdsFAIPER.Edit;
              cdsFAIPERAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString;
              cdsFAIPERFAI_CODFAI.AsString := qryAux.FieldByName('FAI_CODFAI').AsString;
              cdsFAIPER.Post;
            End;
            cdsFAIPER.Next;
          End;

        Finally
          FreeAndNil(qryAux);
        End;
      End;

      //Grava FAIVEN
      If Not cdsFAIVEN.IsEmpty Then
      Begin

        Try
          qryAux := fCriaQuery;

          qryAux.Close;
          qryAux.SQL.Clear;
          qryAux.SQL.Add('SELECT * FROM FAIVEN WHERE FALSE');
          qryAux.Open;

          cdsFAIVEN.First;
          While Not cdsFAIVEN.Eof Do
          Begin
            If fEmptyStr(cdsFAIVENAUTOINCREM.AsString) Then
            Begin

              qryAux.Append;
              qryAux.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('FAIVEN', VS_strCodEmp);
              qryAux.FieldByName('FAI_CODFAI').AsString := dbeCodFai.Text;
              qryAux.FieldByName('FAI_CODVEN').AsString := cdsFAIVENFAI_CODVEN.AsString;
              qryAux.Post;

              cdsFAIVEN.Edit;
              cdsFAIVENAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString;
              cdsFAIVENFAI_CODFAI.AsString := qryAux.FieldByName('FAI_CODFAI').AsString;
              cdsFAIVEN.Post;
            End;
            cdsFAIVEN.Next;
          End;
        Finally
          FreeAndNil(qryAux);
        End;

      End;

      pProcessarDeletados;

      fCommit();

      dbgFaixaDeMargem.Enabled := False;
      dbgVendedores.Enabled    := False;

      cdsFAIPER.First;
      cdsFAIVEN.First;

    End
    Else
      fRollBack;

  Except
    On E: Exception Do
    Begin
      fRollBack();
      pMensagensErro('Erro: ' + E.Message, '[untCadSinaleiroFaturamento - btnGravarClick]');
    End;
  End;

end;

procedure TfrmCadSinaleiroFaturamento.btnIncluirClick(Sender: TObject);
begin
  inherited;

  cdsFAIPER.EmptyDataSet;
  cdsFAIVEN.EmptyDataSet;

  If blnUsaProCodigo Then
    pHabilitaCodigo(dbeCodFai, dbeDesFai, False)
  Else
    pHabilitaCodigo(dbeCodFai, dbeDesFai, True);

  dbgFaixaDeMargem.Enabled := True;
  dbgVendedores.Enabled    := True;

  pgcDados.TabIndex := 0;
  pSetFocus(dbeDesFai);

end;

procedure TfrmCadSinaleiroFaturamento.btnPesquisaClick(Sender: TObject);
Var
  chrKey : Char;
  arrMat : TConsultasArray;
begin
  chrKey := '/';
  If fPesqSinaleiroFaturamento(Self, Nil, Nil, qryTabela, chrKey, arrMat) Then
  Begin
    pSetFocus(btnAlterar);
    pCarregarAbas;
  End;
end;

procedure TfrmCadSinaleiroFaturamento.dbgFaixaDeMargemDrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin

  inherited;

  If (Column.FieldName = 'FAI_CORFAI') Then
  Begin
    If Not fEmptyStr(cdsFAIPER.FieldByName(Column.Field.FieldName).AsString) Then
    Begin
      dbgFaixaDeMargem.Canvas.Brush.Color := StrToIntDef(cdsFAIPER.FieldByName(Column.Field.FieldName).AsString, 0);
      dbgFaixaDeMargem.Canvas.Font.Color  := StrToIntDef(cdsFAIPER.FieldByName(Column.Field.FieldName).AsString, 0);
      dbgFaixaDeMargem.Canvas.FillRect(Rect);
      dbgFaixaDeMargem.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    End;
  End;

end;

procedure TfrmCadSinaleiroFaturamento.dbgFaixaDeMargemKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

  inherited;

  If Not dbgFaixaDeMargem.Enabled Then
    Exit;

  If cdsFAIPER.IsEmpty Then
    Exit;

  If (Key = VK_Delete) Then
    If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
      cdsFAIPER.Delete;

end;

procedure TfrmCadSinaleiroFaturamento.dbgVendedoresKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If Not dbgVendedores.Enabled Then
    Exit;

  If cdsFAIVEN.IsEmpty Then
    Exit;

  If (Key = VK_Delete) Then
    If fMensagem('AVISO', 'Deseja realmente excluir esse registro?', ['&Sim', '&Não']) = 1 Then
      cdsFAIVEN.Delete;

end;

procedure TfrmCadSinaleiroFaturamento.edtCodVenExit(Sender: TObject);
begin
  inherited;
  pEdtCodSelectExit(edtCodVen, edtNomVen, arrVendedor, fRetNomVendRep, nil, 'do vendedor', 3);
end;

procedure TfrmCadSinaleiroFaturamento.edtCodVenKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If fPesqOperador(Self, edtCodVen, edtNomVen, Nil, Key, arrVendedor, False) Then
    If fValidaCampos(edtCodVen, True) Then
      SelectNext(ActiveControl, True, True);
end;

procedure TfrmCadSinaleiroFaturamento.edtCorSinaleiroChange(Sender: TObject);
Var
  strColor : String;
begin

  inherited;

  Try

    strColor := TEditFocus(Sender).Text;

    If not fEmptyStr(strColor) Then
    Begin
      TEditFocus(Sender).Color       := StrToIntDef(strColor,0);
      TEditFocus(Sender).NormalColor := StrToIntDef(strColor,0);
      TEditFocus(Sender).FocusColor  := StrToIntDef(strColor,0);
      TEditFocus(Sender).Font.Color  := StrToIntDef(strColor,0);
    End
    Else
    Begin
      TEditFocus(Sender).Color       := clWindow;
      TEditFocus(Sender).NormalColor := clWindow;
      TEditFocus(Sender).FocusColor  := clWindow;
      TEditFocus(Sender).Font.Color  := clBlack;
    End;

  except

  End;

end;

procedure TfrmCadSinaleiroFaturamento.edtCorSinaleiroClick(Sender: TObject);
begin
  inherited;
  lblCorSinaleiroClick(Self);
end;

procedure TfrmCadSinaleiroFaturamento.FormCreate(Sender: TObject);
begin
  inherited;

  strNomeTabela     := 'FAIMAR';
  strNomeCampo      := 'FAI_CODFAI';
  qryTabela         := fCriarQuery('SELECT * FROM FAIMAR', Self);
  dscFAIMAR.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeCodFai;

  cdsFAIPER.CreateDataSet;
  cdsFAIPER.EmptyDataSet;

  cdsFAIVEN.CreateDataSet;
  cdsFAIVEN.EmptyDataSet;

  pgcDados.ActivePageIndex := 0;

end;

procedure TfrmCadSinaleiroFaturamento.FormShow(Sender: TObject);
var
  intCnt : Integer;
begin

  inherited;

  {Ajusta labels}
  for intCnt := 0 to Self.ComponentCount -1 do
    If (Components[intCnt] Is TLabel) Then
      If (fMargem_ou_Markup = 'MARKUP') Then
        (Components[intCnt] As TLabel).Caption := StringReplace((Components[intCnt] As TLabel).Caption, 'Margem', 'Markup', [rfReplaceAll]);

  If (fMargem_ou_Markup = 'MARKUP') Then
    tbsGeral.Caption := '&1 - Faixa de Markup';

end;

function TfrmCadSinaleiroFaturamento.fPodeGravar: Boolean;
begin

  Result := False;

  If (cdsFAIPER.IsEmpty) Then
  Begin
    fMensagem('Atenção!', 'Nenhuma Faixa de Margem foi informada!', ['&OK']);
    Exit;
  End;

  If (cdsFAIVEN.IsEmpty) Then
  Begin

    If fGetMenu('Nenhum vendedor foi informado na aba "Vendedores". O que deseja fazer?',
                ['Ir para aba de Vendedores', 'Gravar o cadastro para todos os vendedores'],
                1,
                False,
                False,
                300) = 1 Then
    Begin
      pgcDados.TabIndex := 1;
      Exit;
    End;

  End;

  If Not fValidarFaixasConflitantes Then
    Exit;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean): Boolean;
var
  i : Integer;
begin

  Result := Inherited fValidaCampos(Sender, blnBuscaPorChave);

  If Result Then
  Begin

    If (Sender = dbeDesFai) Then
    Begin

      If fEmptyStr(dbeDesFai.Text) Then
      Begin
        fMensagem('', 'Informe a descrição!', ['&OK']);
        Result := False;
      End;

    End

    Else

    If (Sender = edtCodVen) Then
    Begin

      If Not fEmptyStr(edtCodVen.Text) Then
      Begin

        If (Length(arrVendedor) > 1) Then
        Begin

          For i := 0 To Length(arrVendedor) -1 Do
          Begin
            edtCodVen.Text := arrVendedor[i].strCodigo;
            edtNomVen.Text := fRetNomVendRep(arrVendedor[i].strCodigo);
            btnAdicionarVendedoresClick(Self);
          End;

          pLimparAbaVendedores;

        End;

      End
      Else
      Begin
        edtCodVen.Clear;
        edtNomVen.Clear;
      End;

    End;

  End;

  If not Result Then
    pSetFocus(Sender);

end;

function TfrmCadSinaleiroFaturamento.fValidarFaixaComVendedores: Boolean;
var
  qryFaixas           : TUniQuery;
  strFaixaConflitante : String;
  stlVendedores       : TStringList;
begin

  Result := False;

  stlVendedores := TStringList.Create;
  stlVendedores.Clear;

  qryFaixas := fCriaQuery();
  cdsFAIPER.DisableControls;

  Try

    qryFaixas.Close;
    qryFaixas.SQL.Clear;
    qryFaixas.SQL.Add('SELECT            ');
    qryFaixas.SQL.Add('  MAR.FAI_CODFAI, ');
    qryFaixas.SQL.Add('  MAR.FAI_DESFAI, ');
    qryFaixas.SQL.Add('  PER.FAI_MARINI, ');
    qryFaixas.SQL.Add('  PER.FAI_MARFIN  ');
    qryFaixas.SQL.Add('FROM              ');
    qryFaixas.SQL.Add('  FAIMAR MAR      ');
    qryFaixas.SQL.Add('  INNER JOIN FAIPER PER ON (PER.FAI_CODFAI = MAR.FAI_CODFAI) ');
    qryFaixas.SQL.Add('WHERE 1=1');

    If Not fEmptyStr(dbeCodFai.Text) Then
      qryFaixas.SQL.Add('AND MAR.FAI_CODFAI <> ' + QuotedStr(dbeCodFai.Text));

    {Busca faixa para os informados e faixa de "todos"...}
    cdsFAIVEN.First;
    While Not cdsFAIVEN.Eof Do
    Begin
      stlVendedores.Add(QuotedStr(cdsFAIVENFAI_CODVEN.AsString));
      cdsFAIVEN.Next;
    End;

    qryFaixas.SQL.Add(' AND ((SELECT COUNT(*) FROM FAIVEN VEN WHERE VEN.FAI_CODFAI = MAR.FAI_CODFAI AND VEN.FAI_CODVEN IN ('+stlVendedores.CommaText+')) > 0 OR ');
    qryFaixas.SQL.Add('     (SELECT COUNT(*) FROM FAIVEN VEN WHERE VEN.FAI_CODFAI = MAR.FAI_CODFAI) = 0) ');

    qryFaixas.SQL.Add('ORDER BY                         ');
    qryFaixas.SQL.Add('  PER.FAI_CODFAI, PER.FAI_MARINI ');
    qryFaixas.Open;

    If Not qryFaixas.IsEmpty Then
    Begin

      cdsFAIPER.First;
      While Not cdsFAIPER.Eof Do
      Begin

        qryFaixas.First;
        While Not qryFaixas.Eof Do
        Begin

          If fValidarFaixas(cdsFAIPERFAI_MARINI.AsFloat,
                            cdsFAIPERFAI_MARFIN.AsFloat,
                            qryFaixas.FieldByName('FAI_MARINI').AsFloat,
                            qryFaixas.FieldByName('FAI_MARFIN').AsFloat) Then
          Begin
            strFaixaConflitante := 'Faixa de Margem informada: ' + cdsFAIPERFAI_MARINI.AsString + ' - ' + cdsFAIPERFAI_MARFIN.AsString;
            fMensagem('ATENÇÃO!', 'Já existe outro cadastro de faixa de margem com os dados informados. Favor verificar.' + #13 +
                                  strFaixaConflitante + #13 +
                                  'Vendedor(es): ' + stlVendedores.CommaText + #13 +
                                  'Cadastro localizado com os mesmos dados:' + #13 +
                                  'Cadastro: ' + qryFaixas.FieldByName('FAI_CODFAI').AsString + ' - ' + qryFaixas.FieldByName('FAI_DESFAI').AsString, ['&Ok']);
            Exit;
          End;

          qryFaixas.Next;

        End;

        cdsFAIPER.Next;

      End;

    End;

  Finally
    FreeAndNil(stlVendedores);
    FreeAndNil(qryFaixas);
    cdsFAIPER.EnableControls;
  End;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValidarFaixas(fltIni, fltFin, fltIni_, fltFin_: Double): Boolean;
begin

  Result := False;

  If fValorDentroFaixa(fltIni, fltIni_, fltFin_) Then
    Exit(True);

  If fValorDentroFaixa(fltFin, fltIni_, fltFin_) Then
    Exit(True);

end;

function TfrmCadSinaleiroFaturamento.fValidarFaixasConflitantes: Boolean;
begin

  Result := False;

  If cdsFAIVEN.IsEmpty Then
  Begin
    If Not fValidarFaixaSemVendedores Then
      Exit;
  End
  Else
  Begin
    If Not fValidarFaixaComVendedores Then
      Exit;
  End;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValidarFaixaSemVendedores: Boolean;
var
  qryFaixas           : TUniQuery;
  strFaixaConflitante : String;
begin

  Result := False;

  qryFaixas := fCriaQuery();
  cdsFAIPER.DisableControls;

  Try

    qryFaixas.Close;
    qryFaixas.SQL.Clear;
    qryFaixas.SQL.Add('SELECT            ');
    qryFaixas.SQL.Add('  MAR.FAI_CODFAI, ');
    qryFaixas.SQL.Add('  MAR.FAI_DESFAI, ');
    qryFaixas.SQL.Add('  PER.FAI_MARINI, ');
    qryFaixas.SQL.Add('  PER.FAI_MARFIN  ');
    qryFaixas.SQL.Add('FROM              ');
    qryFaixas.SQL.Add('  FAIMAR MAR      ');
    qryFaixas.SQL.Add('  INNER JOIN FAIPER PER ON (PER.FAI_CODFAI = MAR.FAI_CODFAI) ');

    If Not fEmptyStr(dbeCodFai.Text) Then
      qryFaixas.SQL.Add('WHERE MAR.FAI_CODFAI <> ' + QuotedStr(dbeCodFai.Text));

    qryFaixas.SQL.Add('ORDER BY                         ');
    qryFaixas.SQL.Add('  PER.FAI_CODFAI, PER.FAI_MARINI ');
    qryFaixas.Open;

    If Not qryFaixas.IsEmpty Then
    Begin

      cdsFAIPER.First;
      While Not cdsFAIPER.Eof Do
      Begin

        qryFaixas.First;
        While Not qryFaixas.Eof Do
        Begin

          If fValidarFaixas(cdsFAIPERFAI_MARINI.AsFloat,
                            cdsFAIPERFAI_MARFIN.AsFloat,
                            qryFaixas.FieldByName('FAI_MARINI').AsFloat,
                            qryFaixas.FieldByName('FAI_MARFIN').AsFloat) Then
          Begin
            strFaixaConflitante := 'Faixa de Margem informada: ' + cdsFAIPERFAI_MARINI.AsString + ' - ' + cdsFAIPERFAI_MARFIN.AsString;
            fMensagem('ATENÇÃO!', 'Já existe outro cadastro de faixa de margem com os dados informados. Favor verificar.' + #13 +
                                  strFaixaConflitante + #13 +
                                  'Cadastro localizado com os mesmos dados:' + #13 +
                                  'Cadastro: ' + qryFaixas.FieldByName('FAI_CODFAI').AsString + ' - ' + qryFaixas.FieldByName('FAI_DESFAI').AsString, ['&Ok']);
            Exit;
          End;

          qryFaixas.Next;

        End;

        cdsFAIPER.Next;

      End;

    End;

  Finally
    FreeAndNil(qryFaixas);
    cdsFAIPER.EnableControls;
  End;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValidouAbaFaixaDeMargem: Boolean;
var
  strFaixaConflitante : String;
begin

  Result := False;

  If Not edtMarIni.Enabled Then
    Exit;

  If fEmptyStr(edtMarIni.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a margem inicial!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(edtMarFin.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a margem final!', ['&Ok']);
    Exit;
  End;

  If (fStrToFloat(edtMarIni.Text) > fStrToFloat(edtMarFin.Text)) Then
  Begin
    fMensagem('ATENÇÃO!', 'Margem inicial maior que a margem final!', ['&Ok']);
    Exit;
  End;

  If fEmptyStr(edtCorSinaleiro.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe a cor do sinaleiro!', ['&Ok']);
    Exit;
  End;

  {Valida margens conflitantes}
  strFaixaConflitante := '';

  If Not cdsFAIPER.IsEmpty Then
  Begin

    cdsFAIPER.DisableControls;

    Try

      cdsFAIPER.First;
      While Not cdsFAIPER.Eof Do
      Begin

        If fValidarFaixas(fStrToFloat(edtMarIni.Text),
                          fStrToFloat(edtMarFin.Text),
                          cdsFAIPERFAI_MARINI.AsFloat,
                          cdsFAIPERFAI_MARFIN.AsFloat) Then
        Begin
          strFaixaConflitante := 'Faixa - Inicial: ' + cdsFAIPERFAI_MARINI.AsString + ' Final: ' + cdsFAIPERFAI_MARFIN.AsString;
          fMensagem('ATENÇÃO!', 'Já existe uma faixa de margem com este intervalo.' + #13 + 'Ajuste os valores e tente confirmar novamente!' + #13 + strFaixaConflitante, ['&Ok']);
          Exit;
        End;

        cdsFAIPER.Next;

      End;

    Finally
      cdsFAIPER.EnableControls;
    End;

  End;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValidouAbaVendedores: Boolean;
begin

  Result := False;

  If Not edtCodVen.Enabled Then
    Exit;

  If fEmptyStr(edtCodVen.Text) Then
  Begin
    fMensagem('ATENÇÃO!', 'Informe o vendedor!', ['&Ok']);
    Exit;
  End;

  If Not cdsFAIVEN.IsEmpty Then
  Begin

    cdsFAIVEN.DisableControls;

    Try

      If cdsFAIVEN.Locate('FAI_CODVEN', edtCodVen.Text, []) Then
      Begin
        fMensagem('ATENÇÃO!', 'Vendedor já adicionado!', ['&Ok']);
        Exit;
      End;

    Finally
      cdsFAIVEN.EnableControls;
    End;

  End;

  Result := True;

end;

function TfrmCadSinaleiroFaturamento.fValorDentroFaixa(fltValor, fltFaixaIni, fltFaixaFin: Double): Boolean;
begin

  Result := False;

  If Not (fltValor >= fltFaixaIni) Then
    Exit;

  If Not (fltValor <= fltFaixaFin) Then
    Exit;

  Result := True;

end;

procedure TfrmCadSinaleiroFaturamento.lblCorSinaleiroClick(Sender: TObject);
begin
  inherited;

  If Not edtMarIni.Enabled Then
    Exit;

  cldCores.Color := StrToIntDef(TEditFocus(TLabel(Sender).FocusControl).Text,0);

  If (cldCores.Execute) Then
    TEditFocus(TLabel(Sender).FocusControl).Text := IntToStr(cldCores.Color);

end;

procedure TfrmCadSinaleiroFaturamento.pCarregarAbas;
var
  qryAux    : TUniQuery;
  strCodFai : String;
begin

  cdsFAIPER.EmptyDataSet;
  cdsFAIVEN.EmptyDataSet;

  strCodFai := dbeCodFai.Text;

  If Not fEmptyStr(strCodFai) Then
  Begin

    qryAux := fCriaQuery();

    Try

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM FAIPER WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
      qryAux.Open;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin

        cdsFAIPER.Append;
        cdsFAIPERAUTOINCREM.AsString := qryAux.FieldByName('AUTOINCREM').AsString;
        cdsFAIPERFAI_CODFAI.AsString := qryAux.FieldByName('FAI_CODFAI').AsString;
        cdsFAIPERFAI_MARINI.AsFloat  := qryAux.FieldByName('FAI_MARINI').AsFloat;
        cdsFAIPERFAI_MARFIN.AsFloat  := qryAux.FieldByName('FAI_MARFIN').AsFloat;
        cdsFAIPERFAI_CORFAI.AsString := qryAux.FieldByName('FAI_CORFAI').AsString;
        cdsFAIPER.Post;

        qryAux.Next;

      End;

      cdsFAIPER.First;

      qryAux.Close;
      qryAux.SQL.Clear;
      qryAux.SQL.Add('SELECT * FROM FAIVEN WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
      qryAux.Open;

      qryAux.First;
      While Not qryAux.Eof Do
      Begin

        cdsFAIVEN.Append;
        cdsFAIVENAUTOINCREM.AsString  := qryAux.FieldByName('AUTOINCREM').AsString;
        cdsFAIVENFAI_CODFAI.AsString  := qryAux.FieldByName('FAI_CODFAI').AsString;
        cdsFAIVENFAI_CODVEN.AsString  := qryAux.FieldByName('FAI_CODVEN').AsString;
        cdsFAIVENCODIGO_NOME.AsString := qryAux.FieldByName('FAI_CODVEN').AsString + ' - ' + fRetNomVendRep(qryAux.FieldByName('FAI_CODVEN').AsString);
        cdsFAIVEN.Post;

        qryAux.Next;

      End;

      cdsFAIVEN.Next;

    Finally
      FreeAndNil(qryAux);
    End;

    cdsFAIPER.First;
    cdsFAIVEN.First;

  End;

end;

procedure TfrmCadSinaleiroFaturamento.pInicializaIndices;
begin
  inherited;

  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('FAI_CODFAI');
  stlCampos.Add('FAI_DESFAI');
  stlCampos.Add('AUTOINCREM');

  stlCamInd.Add('FAI_DESFAI');
  stlCamInd.Add('FAI_CODFAI');

  stlDesInd.Add('Descrição');
  stlDesInd.Add('Código');

end;

procedure TfrmCadSinaleiroFaturamento.pLimparAbaFaixaDeMargem;
begin
  edtMarIni.Clear;
  edtMarFin.Clear;
  edtCorSinaleiro.Clear;
end;

procedure TfrmCadSinaleiroFaturamento.pLimparAbaVendedores;
begin
  edtCodVen.Clear;
  edtNomVen.Clear;
end;

procedure TfrmCadSinaleiroFaturamento.pNewRecord(DataSet: TDataSet);
begin
  Abort;
end;

procedure TfrmCadSinaleiroFaturamento.pProcessarDeletados;
var
  qryAux    : TUniQuery;
  strCodFai : String;
begin

  strCodFai := dbeCodFai.Text;

  If fEmptyStr(strCodFai) Then
    Exit;

  qryAux := fCriaQuery();

  Try

    {Faixa de Margens}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM FAIPER WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
    qryAux.Open;

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      cdsFAIPER.DisableControls;
      Try
        If Not cdsFAIPER.Locate('AUTOINCREM', qryAux.FieldByName('AUTOINCREM').AsString, []) Then
        Begin
          qryAux.Delete;
          qryAux.Prior;
        End;
      Finally
        cdsFAIPER.EnableControls;
      End;
      qryAux.Next;
    End;

    {Vendedores}
    qryAux.Close;
    qryAux.SQL.Clear;
    qryAux.SQL.Add('SELECT * FROM FAIVEN WHERE FAI_CODFAI = ' + QuotedStr(strCodFai));
    qryAux.Open;

    qryAux.First;
    While Not qryAux.Eof Do
    Begin
      cdsFAIVEN.DisableControls;
      Try
        If Not cdsFAIVEN.Locate('AUTOINCREM', qryAux.FieldByName('AUTOINCREM').AsString, []) Then
        Begin
          qryAux.Delete;
          qryAux.Prior;
        End;
      Finally
        cdsFAIVEN.EnableControls;
      End;
      qryAux.Next;
    End;

  Finally
    FreeAndNil(qryAux);
  End;

end;

end.
