unit untCadAltPar;

interface

uses
  Windows, Classes, Controls, Forms, untPaiCad, AppEvnts, Menus, ComCtrls,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, DB, EditFocus, DBEditFocus,Uni,
  Mask, DBCtrls, frxClass, frxExportCSVTestabilidade;

type
  TfrmCadAltPar = class(TfrmPaiCad)
    dtsAltPar: TDataSource;
    pnlFundo: TPanel;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    dbeDtaAlt: TDBEditFocus;
    dbeCamAlt: TEditFocus;
    dbeValAnt: TEditFocus;
    lbl2: TLabel;
    dbeOpeAlt: TDBEditFocus;
    edtNomOpe: TEditFocus;
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnPesquisaClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure dbeValAntKeyPress(Sender: TObject; var Key: Char);
    procedure btnGravarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    qryAltPar: TUniQuery;
    Function fValidaCidade(strCodCid: String): Boolean;
    procedure pAfterScroll(DataSet: TDataSet);
    function fRetornaZerosNumIes(strIES: String): String;
  protected
    procedure pInicializaIndices; override;
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    strTipoPart: String;
    strCodPart: String;
    { Public declarations }
  end;

implementation

uses SysUtils, StrUtils, untFuncoesSimples, untPai, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmCadAltPar.btnAlterarClick(Sender: TObject);
begin
  inherited;
  pSetFocus(dbeValAnt);
end;

procedure TfrmCadAltPar.btnExcluirClick(Sender: TObject);
begin
  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAltPar.btnExcluirClick]');
    End;
  End;

  If blnExcluiu Then
    fCommit
  Else
    fRollBack;

  dbeCamAlt.Clear;
  dbeValAnt.Clear;
end;

procedure TfrmCadAltPar.btnGravarClick(Sender: TObject);
begin
  If qryTabela.FieldByName('ALT_CONANT').AsString <> dbeValAnt.Text Then
  Begin
    qryTabela.FieldByName('ALT_OPEALT').AsString := strLoginUsuarioLogado;  
    qryTabela.FieldByName('ALT_CONANT').AsString := dbeValAnt.Text;
  End;

  If (Not fValidacoesBotaoGravarPai) Then
    Exit;

  blnStartTransactionNoPaiMasCommitRoolBackNoFilho := True;

  Try
    inherited;
  Except
    On E: Exception Do
    Begin
      fRollBack;
      pMensagensErro(E.Message, '[untCadAltPar.btnGravarClick]');
    End;
  End;

  If blnGravou Then
    fCommit
  Else
    fRollBack;

  pAfterScroll(qryTabela);
end;

procedure TfrmCadAltPar.pAfterScroll(DataSet: TDataSet);
begin
  edtNomOpe.Text := fRetNomeOperador(dbeOpeAlt.Text);
end;

procedure TfrmCadAltPar.btnPesquisaClick(Sender: TObject);
  Var
    chrKey: Char;
    arrAltPar: TConsultasArray;
    strNumCam: String;
begin
  chrKey := '/';
  If fPesqAltPar(Self, Nil, dbeCamAlt, Nil, qryTabela, chrKey, arrAltPar, strTipoPart, strCodPart) Then
  Begin
    strNumCam := qryTabela.FieldByName('ALT_NUMCAM').AsString;
    If strNumCam = '03' Then   //Nome
    Begin
      dbeValAnt.MaxLength := 60;
      dbeValAnt.TamCampo  := 60;
      dbeValAnt.CompZeros := False;
    End
    Else If strNumCam = '04' Then   //CodPais
    Begin
      dbeValAnt.MaxLength := 4;
      dbeValAnt.TamCampo  := 4;
      dbeValAnt.CompZeros := True;
    End
    Else If strNumCam = '05' Then //Cnpj
    Begin
      dbeValAnt.MaxLength := 18;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 18;
      //dbeValAnt.EditMask  := '99.999.999/9999-99;0;';
    End
    Else If strNumCam = '06' Then  //CPF
    Begin
      dbeValAnt.MaxLength := 18;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 18;
      //dbeValAnt.EditMask  := '999.999.999-99;0;';
    End
    Else If strNumCam = '07' Then //IES
    Begin
      dbeValAnt.MaxLength := 18;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 18;
    End
    Else If strNumCam = '08' Then  //CodMunicipio
    Begin
      dbeValAnt.MaxLength := 5;
      dbeValAnt.CompZeros := True;
      dbeValAnt.TamCampo  := 5;
    End
    Else If strNumCam = '09' Then //Suframa
    Begin
      dbeValAnt.MaxLength := 9;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 9;
    End
    Else If strNumCam = '10' Then //Endereco
    Begin
      dbeValAnt.MaxLength := 60;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 60;
    End
    Else If strNumCam = '11' Then //NumEndereco
    Begin
      dbeValAnt.MaxLength := 10;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 10;
    End
    Else If strNumCam = '12' Then //ComplEndereco
    Begin
      dbeValAnt.MaxLength := 50;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 50;
    End
    Else If strNumCam = '13' Then //Bairro
    Begin
      dbeValAnt.MaxLength := 60;
      dbeValAnt.CompZeros := False;
      dbeValAnt.TamCampo  := 60;
    End;
    dbeValAnt.Text := qryTabela.FieldByName('ALT_CONANT').AsString;
    pSetFocus(btnAlterar);
  End;
end;

procedure TfrmCadAltPar.dbeValAntKeyPress(Sender: TObject; var Key: Char);
Var
  arrCidade: TConsultasArray;
  qryGen: TUniQuery;
  arrSel: TConsultasArray;
begin
  inherited;
  If dbeCamAlt.Text = 'CÓD MUNICÍPIO' Then
  Begin
    If fPesqCidade(Self, dbeValAnt, Nil, Nil, Nil, Key, arrCidade) Then
    Begin
      If fValidaCampos(dbeValAnt, True) Then
        SelectNext(ActiveControl, True, True);
    End;
  End;

  If dbeCamAlt.Text = 'CÓD PAÍS' Then
  Begin
    qryGen := fCriaQuery(Self);

    If fPesqPaises(Self, dbeCamAlt, qryGen, Key, arrSel) Then
    Begin
      If fValidaCampos(dbeValAnt, True) Then
      Begin
        SelectNext(ActiveControl, True, True);
      End;
    End;

    FreeAndNil(qryGen);
  End;     
end;

procedure TfrmCadAltPar.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;

  If (Action <> CaNone) Then
    qryTabela.AfterScroll := Nil;
end;

procedure TfrmCadAltPar.FormCreate(Sender: TObject);
begin
  inherited;
  strNomeTabela         := 'ALTPAR';
  strNomeCampo          := 'ALT_CODPAR';

  qryAltPar             := fCriaQuery(Self);
  qryTabela             := qryAltPar;
  dtsAltPar.DataSet     := qryTabela;

  qryTabela.AfterScroll := pAfterScroll;

  SetLength(arrCamposChave, 4);
  arrCamposChave[2] := dbeDtaAlt;
  arrCamposChave[3] := dbeCamAlt;
end;

procedure TfrmCadAltPar.FormShow(Sender: TObject);
begin
  inherited;

  btnIncluir.Visible := False;
  btnAlterar.Visible := False;
  btnExcluir.Visible := False;
  btnGravar.Visible := False;
  btnCancela.Visible := False;

  pSetFocus(btnAlterar);
end;

function TfrmCadAltPar.fRetornaZerosNumIes(strIES: String): String;
  var
    intIndice: Integer;
    strOrigem: String;
begin
  For intIndice := 1 To Length(Trim(strIES)) Do
  Begin
    If Pos(strIES[intIndice], '0123456789P') > 0 Then
      strOrigem := strOrigem + strIES[intIndice];
  End;
  result := fPadL('', 10 - Length(strOrigem), '0');
end;

function TfrmCadAltPar.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
 Var qryAux: TUniQuery;
begin
  Result := True;
  If (inherited fValidaCampos(Sender)) Then
  Begin

    If (Sender = dbeValAnt) Then
    Begin
      Try
        qryAux := fCriaQuery;
        qryAux.Close;
        qryAux.SQL.Clear;
        qryAux.SQL.Add(' SELECT CLI_NOMCLI,CID_ESTADO FROM CADCLI ');
        qryAux.SQL.Add(' LEFT JOIN CADCID ON CLI_CODCID = CID_CODCID ');
        qryAux.SQL.Add(' WHERE CLI_CODCLI = :CODCLI');
        qryAux.ParamByName('CODCLI').AsString := qryTabela.FieldByName('ALT_CODPAR').AsString;
        qryAux.Open;

        If fEmptyStr(dbeValAnt.Text) Then
        Begin
          fMensagem('','É necessário preencher o campo "Valor Anterior"', ['&Ok']);
          Result := False;
        End
        Else If dbeCamAlt.Text = 'CÓD MUNICÍPIO' Then
        Begin
          If Not fValidaCidade(dbeValAnt.Text) Then
          Begin
            fMensagem('', 'Essa cidade não está cadastrada!', ['&Ok']);
            Result := False;
          End;
        End
        Else If (dbeCamAlt.Text = 'CNPJ') Or (dbeCamAlt.Text = 'CPF') Then
        Begin
          If dbeCamAlt.Text = 'CNPJ' Then
            Result := fValidaCnpjCpf('1', dbeValAnt.Text, False, True)
          Else
            Result := fValidaCnpjCpf('2', dbeValAnt.Text, False, True);
          If (Result) And (Not fClienteConsumidor(qryAux.FieldByName('CLI_NOMCLI').AsString)) Then
          Begin
            If (Not fExisteCnpjCpf('CADCLI','CLI_CODCLI',qryTabela.FieldByName('ALT_CODPAR').AsString,
                      'CLI_C_G_C_',dbeValAnt.Text,qryAux.FieldByName('CID_ESTADO').AsString)) Then
               Result := True;
          End;
        End
        Else If dbeCamAlt.Text = 'CÓD PAÍS' Then
        Begin
          If fEmptyStr(fRetNomePais(dbeValAnt.Text)) Then
          Begin
            fMensagem('', 'O código do país informado não é válido', ['OK']);
            Result := False;
          end;
        End
        Else If dbeCamAlt.Text = 'INSC. ESTADUAL' Then
        Begin
          If Not fValidaIES(AnsiReplaceStr(dbeValAnt.Text, ',', '.'), qryAux.FieldByName('CID_ESTADO').AsString) Then
          Begin
            fMensagem('', dbeValAnt.Text + ' não é uma Inscrição Estadual válida!', ['&Ok']);
            Result := False;
          End
          Else
          Begin
            If qryAux.FieldByName('CID_ESTADO').AsString = 'RS' Then
            Begin
              dbeValAnt.Text := fRetornaZerosNumIes(dbeValAnt.Text) + dbeValAnt.Text;
            End;
          End;
        End;
      Finally
        FreeAndNil(qryAux);
      end;
    End;
  End;

  If (Not Result) Then
    pSetFocus(Sender);
end;

function TfrmCadAltPar.fValidaCidade(strCodCid: String): Boolean;
begin

  Result := False;

  If fEmptyStr(strCodCid) Then
    Exit;

  Result := ( fCampoTabela('COUNT(*) AS QTD', 'CADCID', ['CID_CODCID'], [strCodCid], False) > 0 );

end;

procedure TfrmCadAltPar.pInicializaIndices;
begin
  inherited;
  stlCampos := TStringList.Create;
  stlCamInd := TStringList.Create;
  stlDesInd := TStringList.Create;

  stlCampos.Add('ALT_CODPAR');
  stlCampos.Add('ALT_TIP_FC');
  stlCampos.Add('ALT_DTAALT');
  stlCampos.Add('ALT_NUMCAM');

  stlCamInd.Add('ALT_CODPAR+ALT_TIP_FC');
  stlCamInd.Add('ALT_DTAALT');

  stlDesInd.Add('Código Cliente-Fornecedor-Consumidor / Cliente-Fornecedor-Consumidor');
  stlDesInd.Add('Data Alteração');
end;

end.
