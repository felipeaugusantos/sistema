unit untCadCotacaoMoeda;

interface

uses
  Windows, Classes, Controls, untPaiCad, AppEvnts, Menus, ComCtrls, StdCtrls,
  Buttons, ExtCtrls, DBCtrls, DBEditFocus, untCotacaoMoeda, DB, Uni,
  BitBtnLockedIncrem, Mask, frxClass, frxExportCSVTestabilidade,
  untConsultas;

type
  TfrmCadCotacaoMoeda = class(TfrmPaiCad)
    pnlFundo: TPanel;
    dtsCadMoe: TDataSource;
    Panel1: TPanel;
    Label1: TLabel;
    dbeDtaMoe: TDBEditFocus;
    Panel2: TPanel;
    dbeDolCom: TDBEditFocus;
    dbeDolVen: TDBEditFocus;
    Label4: TLabel;
    lblMoeda: TLabel;
    dbeReaCom: TDBEditFocus;
    dbeReaVen: TDBEditFocus;
    Label6: TLabel;
    dbeParCom: TDBEditFocus;
    dbeParVen: TDBEditFocus;
    dbeEurVen: TDBEditFocus;
    dbeEurCom: TDBEditFocus;
    Label8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Panel3: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
  private
    { Private declarations }
    objCotMoe: TCotMoe; // cria um objeto da Classe TCotMoe - untCotacaoMoeda
    procedure pRecalcularOsProdutos;
    procedure pRecalcularProdutosDolar;

    function fUltimaCotaocaoDolar: Boolean;
    function fExisteProdutoEmDolar: Boolean;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma : Boolean;
    blnInicio   : Boolean;
  end;

implementation

uses SysUtils, Forms, untFuncoesSimples, untPai, untFuncoesGenerica,
     untRecalcularProdutosDolar;

{$R *.dfm}

procedure TfrmCadCotacaoMoeda.FormCreate(Sender: TObject);
begin
  inherited;
  objCotMoe := TCotMoe.Create(Self);

  strNomeTabela := 'CADMOE';
  strNomeCampo  := 'MOE_DTAMOE';

  qryTabela     := objCotMoe.qryCadMoe;

  dtsCadMoe.DataSet := qryTabela;

  SetLength(arrCamposChave, 1);
  arrCamposChave[0] := dbeDtaMoe;
end;

procedure TfrmCadCotacaoMoeda.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(objCotMoe);
end;

procedure TfrmCadCotacaoMoeda.pInicializaIndices;
begin
  inherited;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCamInd.Add('MOE_DTAMOE');
  stlCamInd.Add('MOE_CODEMP');

  stlDesInd.Add('Data');
  stlDesInd.Add('Empresa');
end;

procedure TfrmCadCotacaoMoeda.pRecalcularOsProdutos;
  Var
    objRecProdDolar: TRecalcularProdutosDolar;
begin
  objRecProdDolar := TRecalcularProdutosDolar.Create;
  Try
    objRecProdDolar.pRecalcularOsProdutos;
  Finally
    FreeAndNil(objRecProdDolar);
  End;
end;

procedure TfrmCadCotacaoMoeda.pRecalcularProdutosDolar;
begin
  If (qryTabela.FieldByName('MOE_DOLVEN').AsFloat > 0) And fUltimaCotaocaoDolar Then
  Begin
    If fExisteProdutoEmDolar Then
      If (fMensagem('ATENÇÃO', 'Existem produtos que estão calculados em dolar.' + #13#10 + ' Deseja recalcular ?', ['&Sim', '&Não']) = 1) Then
        pRecalcularOsProdutos;
  End
end;

procedure TfrmCadCotacaoMoeda.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
begin
  chrKey := '/';

  If fPesqCotacaoMoeda(Self, Nil, Nil, qryTabela, chrKey) Then
    If (btnAlterar.Enabled) And (btnAlterar.Visible) Then
      pSetFocus(btnAlterar);
end;

procedure TfrmCadCotacaoMoeda.btnIncluirClick(Sender: TObject);
begin
  inherited;
  blnUsaProCodigo := False;
  If blnInicio Then
    pSetFocus(dbeDolCom)
  Else
    pSetFocus(dbeDtaMoe);
end;

procedure TfrmCadCotacaoMoeda.btnGravarClick(Sender: TObject);
begin
  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  qryTabela.FieldByName('MOE_CODEMP').AsString := VS_strCodEmp;

  If fSetaPais = opcParaguai Then
  Begin
    qryTabela.FieldByName('MOE_GUACOM').AsFloat := 0.0;
    qryTabela.FieldByName('MOE_GUAVEN').AsFloat := 0.0;
  End
  Else
  Begin
    qryTabela.FieldByName('MOE_REACOM').AsFloat := 0.0;
    qryTabela.FieldByName('MOE_REAVEN').AsFloat := 0.0;
  End;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCotacaoMoeda.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  //Se utilizar o modulo industrial, entao recalcula os produtos que estao
  //marcados como produtos em dolar no cadastro de produtos.
  If fCfgSis('COTDOR', varBoolean) And (Not fPreMat) Then
    pRecalcularProdutosDolar;

  If blnInicio Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmCadCotacaoMoeda.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeDtaMoe);
end;

function TfrmCadCotacaoMoeda.fUltimaCotaocaoDolar: Boolean;
var
  qryCons: TUniQuery;
begin
  Result := False;
  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;
        SQL.Add('SELECT MOE_DTAMOE FROM CADMOE ORDER BY MOE_DTAMOE DESC LIMIT 1');
        Open;

        If Not IsEmpty Then
        Begin
          //Se a data do dolar que esta sendo alterado for igual a ultima data de cotacao
          //entao permite recalcular os produtos dolar.
          If FieldByName('MOE_DTAMOE').AsDateTime = StrToDateTime(dbeDtaMoe.Text) Then
            Result := True;
        End;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fUltimaCotaocaoDolar]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

function TfrmCadCotacaoMoeda.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin

  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    {*******************}
    {* VALIDA A DATA   *}
    {****************LU*}
    If (Sender = dbeDtaMoe) Then
    Begin

      If fEmptyStr(fTiraCaracEspeciais(dbeDtaMoe.Text)) Then
      Begin
        fMensagem('ATENÇÃO!', 'A Data deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else If blnBuscaPorChave Then
      Begin
        If Not fBuscaPorCamposChave Then
          pLimparCampos
        Else
        Begin

        End;
      End;
      (*
      Begin
        If fVerifCotacao(StrToDateTime(dbeDtaMoe.text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Já existe cotação para essa data!', ['&O k']);
          Result := False;
        End;
      End;
      *)
      
    End

    {*****************************************}
    {* VALIDA  OS VALORES                    *}
    {**************************************LU*}
    Else If (Sender = dbeDolCom) Then
    Begin
      If fEmptyStr(dbeDolCom.Text) Or (dbeDolCom.Text = '0') Or (dbeDolCom.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Compra do Dólar deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeDolVen) Then
    Begin
      If fEmptyStr(dbeDolVen.Text) Or (dbeDolVen.Text = '0') Or (dbeDolVen.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Venda do Dólar deve ser maior que Zero!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = dbeReaCom) Then
    Begin
      If (fEmptyStr(dbeReaCom.Text)) Then
        dbeReaCom.Text := '0,00';

      {If fEmptyStr(dbeReaCom.Text) Or (dbeReaCom.Text = '0') Or (dbeReaCom.Text = '0,00') Then
      Begin
        If fSetaPais = opcParaguai Then
          fMensagem('ATENÇÃO!', 'O Valor de Compra do Real deve ser maior que Zero!', ['&O k'])
        Else
          fMensagem('ATENÇÃO!', 'O Valor de Compra do Guarani deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End

    Else If (Sender = dbeReaVen) Then
    Begin
      If (fEmptyStr(dbeReaVen.Text)) Then
        dbeReaVen.Text := '0,00';

      {If fEmptyStr(dbeReaVen.Text) Or (dbeReaVen.Text = '0') Or (dbeReaVen.Text = '0,00') Then
      Begin
        If fSetaPais = opcParaguai Then
          fMensagem('ATENÇÃO!', 'O Valor de Venda do Real deve ser maior que Zero!', ['&O k'])
        Else
          fMensagem('ATENÇÃO!', 'O Valor de Compra do Guarani deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End

    Else If (Sender = dbeEurCom) Then
    Begin
      If (fEmptyStr(dbeEurCom.Text)) Then
        dbeEurCom.Text := '0,00';

      {If fEmptyStr(dbeEurCom.Text) Or (dbeEurCom.Text = '0') Or (dbeEurCom.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Compra do Euro deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End

    Else If (Sender = dbeEurVen) Then
    Begin
      If (fEmptyStr(dbeEurVen.Text)) Then
        dbeEurVen.Text := '0,00';

      {If fEmptyStr(dbeEurVen.Text) Or (dbeEurVen.Text = '0') Or (dbeEurVen.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Venda do Euro deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End

    Else If (Sender = dbeParCom) Then
    Begin
      If (fEmptyStr(dbeParCom.Text)) Then
        dbeParCom.Text := '0,00';

      {If fEmptyStr(dbeParCom.Text) Or (dbeParCom.Text = '0') Or (dbeParCom.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Compra do Peso deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End

    Else If (Sender = dbeParVen) Then
    Begin
      If (fEmptyStr(dbeParVen.Text)) Then
        dbeParVen.Text := '0,00';

      {If fEmptyStr(dbeParVen.Text) Or (dbeParVen.Text = '0') Or (dbeParVen.Text = '0,00') Then
      Begin
        fMensagem('ATENÇÃO!', 'O Valor de Venda do Peso deve ser maior que Zero!', ['&O k']);
        Result := False;
      End}
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmCadCotacaoMoeda.FormShow(Sender: TObject);
  Var
    fltDolCom,fltDolVen,
    fltReaCom,fltReaVen,
    fltEurCon,fltEurVen,
    fltParCom,fltParVen: Double;
begin
  inherited;
  If fSetaPais = opcParaguai Then
  Begin
    lblMoeda.Caption := 'R$';
    dbeReaCom.DataField := 'MOE_REACOM';
    dbeReaVen.DataField := 'MOE_REAVEN';
  End
  Else
  Begin
    lblMoeda.Caption := 'G$';
    dbeReaCom.DataField := 'MOE_GUACOM';
    dbeReaVen.DataField := 'MOE_GUAVEN';
  End;

  If blnInicio Then
  Begin
    pGetUltimaCotacao(fltDolCom,fltDolVen,
                      fltReaCom,fltReaVen,
                      fltEurCon,fltEurVen,
                      fltParCom,fltParVen);

    btnIncluir.Click;
    qryTabela.FieldByName('MOE_DTAMOE').AsDateTime := VS_Date;

    qryTabela.FieldByName('MOE_DOLCOM').AsFloat := fltDolCom;
    qryTabela.FieldByName('MOE_DOLVEN').AsFloat := fltDolVen;

    qryTabela.FieldByName('MOE_REACOM').AsFloat := fltReaCom;
    qryTabela.FieldByName('MOE_REAVEN').AsFloat := fltReaVen;

    qryTabela.FieldByName('MOE_EURCOM').AsFloat := fltEurCon;
    qryTabela.FieldByName('MOE_EURVEN').AsFloat := fltEurVen;

    qryTabela.FieldByName('MOE_PARCOM').AsFloat := fltParCom;
    qryTabela.FieldByName('MOE_PARVEN').AsFloat := fltParVen;

  End;

end;

procedure TfrmCadCotacaoMoeda.btnCancelaClick(Sender: TObject);
begin
  inherited;
  If blnInicio Then
  Begin
    blnConfirma := False;
    Close;
  End;
end;

procedure TfrmCadCotacaoMoeda.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadCotacaoMoeda.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;
end;

procedure TfrmCadCotacaoMoeda.btnSairClick(Sender: TObject);
begin
  If blnInicio Then
    blnConfirma := False;
  inherited;
end;

function TfrmCadCotacaoMoeda.fExisteProdutoEmDolar: Boolean;
var
  qryCons: TUniQuery;
begin
  Result := False;
  Try
    Try
      qryCons := fCriaQuery(Nil);
      With qryCons Do
      Begin
        Close;
        SQL.Clear;

//        SQL.Add('SELECT ITE_PREDOL FROM ITEGER WHERE ITE_PREDOL = "S" AND ITE_CODEMP = :CODEMP LIMIT 1');

        SQL.Add('SELECT ITE_PREDOL FROM ITEGER WHERE ITE_PREDOL = "S" LIMIT 1');

     //   ParamByName('CODEMP').AsString := VS_strCodEmp;
        Open;

        If Not IsEmpty Then
          Result := True;
      End;
    Except
      on E: Exception do
      begin
        pMensagensErro(E.Message, '[fExisteProdutoEmDolar]');
      end;
    End;
  Finally
    FreeAndNil(qryCons);
  End;
end;

end.

