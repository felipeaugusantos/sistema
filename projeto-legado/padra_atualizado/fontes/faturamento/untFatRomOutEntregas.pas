unit untFatRomOutEntregas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiSimples, AppEvnts, Menus, ComCtrls, StdCtrls, Buttons, Uni,
  ExtCtrls, Grids, DBGridCitel, DBGrids, DB, UniClientDataSet, DBCtrls, EditFocus, BitBtnLockedIncrem,
  Vcl.Mask, MaskEditFocus, frxClass, frxExportCSVTestabilidade, untZClient;

type
  TfrmFatRomOutEntregas = class(TfrmPaiSimples)
    dbgOutEnt: TDBGridCitel;
    pnlDigitacao: TPanel;
    lblRegiao: TLabel;
    edtCodReg: TEditFocus;
    edtDesReg: TEditFocus;
    mskDtaEtr: TMaskEditFocus;
    Label2: TLabel;
    pnlCliente: TPanel;
    edtCodCli: TEditFocus;
    Label3: TLabel;
    edtDesCliente: TEditFocus;
    pnlDescricao: TPanel;
    Label1: TLabel;
    edtOuEnt: TEditFocus;
    btnConfirma: TBitBtnLocked;
    pnlEndereco: TPanel;
    gpbEnderecoEntrega: TGroupBox;
    lblEndCon: TLabel;
    edtEndCon: TEditFocus;
    lblBaiCon: TLabel;
    edtBairro: TEditFocus;
    edtComple: TEditFocus;
    lblComple: TLabel;
    lblCidade: TLabel;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    edtEstado: TEditFocus;
    lblCep: TLabel;
    edtCepCon: TEditFocus;
    lblEndRef: TLabel;
    edtRefCon: TEditFocus;
    pnlPesoValor: TPanel;
    lblPesBru: TLabel;
    lblValDoc: TLabel;
    edtPesBru: TEditFocus;
    edtValDoc: TEditFocus;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodRegKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbgOutEntDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure edtCodCliKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCliExit(Sender: TObject);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure edtCepConKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    cdsOutEnt : TZClient;

    strCepAnt: String;

    procedure pCarregaCadCidade(strCodCid: String);
    procedure pCarregaEnderecoCliente(strCodCli: String);
    procedure pLimpaDadosEntrega;
  public
    { Public declarations }
    FNumRom: String;
    FEmpRom: String;
    FDtaRom: TDateTime;
    FOpeRom: String;

    function fcdsOutEnt: TDataSet;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmFatRomOutEntregas: TfrmFatRomOutEntregas;

implementation

uses untFuncoesSimples, untTypesSistema, untConsultas, untFuncoesConsulta,
  untCadCid, untCadCidades;

{$R *.dfm}

procedure TfrmFatRomOutEntregas.btnConfirmaClick(Sender: TObject);
begin
  inherited;

  If Not fVerificaCampos Then
    Exit;

  cdsOutEnt.Append;
  cdsOutEnt.FieldByName('AUTOINCREM').AsString := fRetAutoIncrem('OUTDIGX', VS_strCodEmp);
  cdsOutEnt.FieldByName('DIG_NUMDOC').AsString := fAtualizaProCod('OUTDIGX', 'DIG_NUMDOC');

  if not fEmptyStr(FNumRom) then
    cdsOutEnt.FieldByName('DIG_NUMROM').AsString := FNumRom;

  if not fEmptyStr(FEmpRom) then
    cdsOutEnt.FieldByName('DIG_EMPROM').AsString := FEmpRom;

  if FDtaRom > 0 then
  begin
    cdsOutEnt.FieldByName('DIG_DTAROM').AsDateTime := FDtaRom;
    cdsOutEnt.FieldByName('DIG_HORROM').AsDateTime := FDtaRom;
  end;

  if not fEmptyStr(FOpeRom) then
    cdsOutEnt.FieldByName('DIG_OPEROM').AsString := FOpeRom;

  cdsOutEnt.FieldByName('DIG_CODVEN').AsString := strLoginUsuarioLogado;
  cdsOutEnt.FieldByName('DIG_ESPDOC').AsString := 'OX';
  cdsOutEnt.FieldByName('DIG_DTAENT').AsDateTime := VS_Date;
  cdsOutEnt.FieldByName('DIG_HORENT').AsDateTime := fTime();
  cdsOutEnt.FieldByName('DIG_DESCRI').AsString := edtOuEnt.Text;
  cdsOutEnt.FieldByName('DIG_CODEMP').AsString := VS_strCodEmp;
  cdsOutEnt.FieldByName('DIG_DTAETR').AsDateTime := StrToDate(mskDtaEtr.Text);

  if (pnlCliente.Visible) and (not fEmptyStr(edtCodCli.Text)) then
    cdsOutEnt.FieldByName('DIG_CODCLI').AsString := edtCodCli.Text;

  If Not fEmptyStr(edtCodReg.Text) Then
    cdsOutEnt.FieldByName('DIG_CODREG').AsString := edtCodReg.Text
  Else
    cdsOutEnt.FieldByName('DIG_CODREG').Value := Null;

  cdsOutEnt.FieldByName('DIG_PESBRU').AsFloat := fStrToFloat(edtPesBru.Text);
  cdsOutEnt.FieldByName('DIG_VALDOC').AsFloat := fStrToFloat(edtValDoc.Text);

  if pnlEndereco.Visible then
  begin
    cdsOutEnt.FieldByName('DIG_ENDCON').AsString := Trim(edtEndCon.Text) + ' - ' + Trim(edtComple.Text);
    cdsOutEnt.FieldByName('DIG_BAIRRO').AsString := edtBairro.Text;
    cdsOutEnt.FieldByName('DIG_CEPCON').AsString := edtCepCon.Text;
    cdsOutEnt.FieldByName('DIG_CODCID').AsString := edtCodCid.Text;
    cdsOutEnt.FieldByName('DIG_NOMCID').AsString := edtNomCid.Text;
    cdsOutEnt.FieldByName('DIG_ESTADO').AsString := edtEstado.Text;
    cdsOutEnt.FieldByName('DIG_REFCON').AsString := edtRefCon.Text;
  end;

  cdsOutEnt.Post;
  cdsOutEnt.fSalva;

  edtOuEnt.Clear;
  edtCodReg.Clear;
  edtDesReg.Clear;

  if pnlCliente.Visible Then
  begin
    edtCodCli.Clear;
    edtDesCliente.Clear;
  end;

  if pnlEndereco.Visible then
    pLimpaDadosEntrega;

  pSetFocus(edtCodReg);

  pnlInfo.Caption := 'Os documentos inseridos aqui serão exibidos na tela do romaneio.';
end;

procedure TfrmFatRomOutEntregas.pLimpaDadosEntrega;
begin
  edtCepCon.Clear;
  edtCodCid.Clear;
  edtNomCid.Clear;
  edtEstado.Clear;
  edtEndCon.Clear;
  edtComple.Clear;
  edtBairro.Clear;
  edtRefCon.Clear;
  edtRefCon.Clear;
  edtPesBru.Text := '0,00';
  edtValDoc.Text := '0,00';
end;

procedure TfrmFatRomOutEntregas.dbgOutEntDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
  Var
    strTexto : String;
begin
  inherited;

  If (dbgOutEnt.Columns.Items[Column.Index] <> Nil) And
     (dbgOutEnt.Columns.Items[Column.Index].Field <> Nil) Then
  Begin
    If (dbgOutEnt.Columns.Items[Column.Index].Field.FieldName = 'DIG_DESCRI') Then
    Begin
      strTexto := dbgOutEnt.DataSource.DataSet.FieldByName('DIG_DESCRI').AsString;
      If fEmptyStr(strTexto) Then
        strTexto := '              ';
      dbgOutEnt.Canvas.TextOut(Rect.Left + 1, Rect.Top + 2, fstrEspaco(strTexto, 14, 1));
    End
    Else If (dbgOutEnt.Columns.Items[Column.Index].Field.FieldName = 'DIG_CODREG') Then
    Begin
      strTexto := dbgOutEnt.DataSource.DataSet.FieldByName('DIG_CODREG').AsString;
      If fEmptyStr(strTexto) Then
        strTexto := '              '
      Else
        strTexto := strTexto + '-' + fRetNomRegiao(strTexto);
      dbgOutEnt.Canvas.TextOut(Rect.Left + 1, Rect.Top + 2, strTexto);
    End;

    If pnlCliente.Visible Then
    begin

      If (dbgOutEnt.Columns.Items[Column.Index].Field.FieldName = 'DIG_CODCLI') Then
      Begin
        strTexto := dbgOutEnt.DataSource.DataSet.FieldByName('DIG_CODCLI').AsString;

        If fEmptyStr(strTexto) Then
          strTexto := '              '
        Else
          strTexto := strTexto + '-' + fRetNomCliente(strTexto);

        dbgOutEnt.Canvas.TextOut(Rect.Left + 1, Rect.Top + 2, strTexto);
      End;

    end;

  End;
end;

procedure TfrmFatRomOutEntregas.edtCepConKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;

  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
    Key := #0;

    edtCepCon.Text := fConsultarCep(Self, edtCepCon.Text, edtCepCon);
  End;
end;

procedure TfrmFatRomOutEntregas.edtCodCidKeyPress(Sender: TObject; var Key: Char);
Var
  arrCidade: TConsultasArray;
begin
  inherited;
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomOutEntregas.edtCodCliExit(Sender: TObject);
var
  arrCli: TConsultasArray;
begin
  inherited;
  pEdtCodSelectExit(edtCodCli, edtDesCliente, arrCli, Nil, fRetNomCliente, 'do Cliente');
end;

procedure TfrmFatRomOutEntregas.edtCodCliKeyPress(Sender: TObject;
  var Key: Char);
var
  arrCli: TConsultasArray;
begin
  inherited;
  If fPesqCliente(conCliSimples, Self, edtCodCli, edtDesCliente, Nil, Key, arrCli, False) Then
  Begin
    fValidaCampos(edtCodCli, True);
    SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmFatRomOutEntregas.edtCodRegKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrRegiao : TConsultasArray;
begin
  inherited;
  If fPesqRegiao(Self, edtCodReg, edtDesReg, Nil, Key, arrRegiao) Then
  Begin
    if fValidaCampos(edtCodReg, True) then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmFatRomOutEntregas.fcdsOutEnt: TDataSet;
begin
  Result := cdsOutEnt;
end;

procedure TfrmFatRomOutEntregas.FormActivate(Sender: TObject);
begin
  inherited;
  pSetFocus(edtCodReg);
end;

procedure TfrmFatRomOutEntregas.FormCreate(Sender: TObject);
begin
  inherited;
  cdsOutEnt := TZClient.Create(Self);
  dbgOutEnt.DataSource := cdsOutEnt.dtsSource;
  FNumRom := EmptyStr;
  FEmpRom := EmptyStr;
  FDtaRom := 0;
  FOpeRom := EmptyStr;
end;

procedure TfrmFatRomOutEntregas.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_DELETE Then
    If ((ActiveControl) = dbgOutEnt) Then
    Begin
      If Not cdsOutEnt.IsEmpty Then
        cdsOutEnt.Delete
      Else
        pSetFocus(edtCodReg);
    End;

  If Key = VK_ESCAPE Then
    If ((ActiveControl) = dbgOutEnt) Then
      pSetFocus(edtCodReg);

  If Key = VK_RETURN Then
    If ((ActiveControl) = dbgOutEnt) Then
      Self.Close;
end;

procedure TfrmFatRomOutEntregas.FormShow(Sender: TObject);
Var
  LColunaCliente : TColumn;
begin
  inherited;

  pnlCliente.Visible := (fCfgSis('FUSUSA', varBoolean) or (fCfgSis('PDCOER', varBoolean)));

  if pnlCliente.Visible Then
  begin
    LColunaCliente := fFindColumnByName(dbgOutEnt, 'DIG_CODCLI');

    If Assigned(LColunaCliente) Then
    begin
       LColunaCliente.Visible := true;
       LColunaCliente.Width   := 350;
    end;
  end;

  mskDtaEtr.Text := FormatDateTime('dd/mm/yyyy', VS_Date);

  cdsOutEnt.Close;
  cdsOutEnt.qryQuery.Close;
  cdsOutEnt.qryQuery.SQL.Clear;
  cdsOutEnt.qryQuery.SQL.Add('SELECT * FROM OUTDIGX WHERE FALSE');
  cdsOutEnt.pSetProvider;
  cdsOutEnt.qryQuery.Open;
  pSetaClient(cdsOutEnt.qryQuery);
  cdsOutEnt.Open;

  (cdsOutEnt.FieldByName('DIG_PESBRU') As TFloatField).DisplayFormat := fMskDigitos(2);
  (cdsOutEnt.FieldByName('DIG_VALDOC') As TFloatField).DisplayFormat := fMskDigitos(2);

  pnlEndereco.Visible := fCfgSis('MATDIS', varBoolean);
  dbgOutEnt.Columns[4].Visible := pnlEndereco.Visible;
  dbgOutEnt.Columns[5].Visible := pnlEndereco.Visible;
  dbgOutEnt.Columns[6].Visible := pnlEndereco.Visible;
  dbgOutEnt.Columns[7].Visible := pnlEndereco.Visible;
  dbgOutEnt.Columns[8].Visible := pnlEndereco.Visible;
end;

function TfrmFatRomOutEntregas.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
var
  strCodCid,
  strEndere,
  strBairro,
  strNomCid,
  strEstado,
  LCodigoCorreio: String;

  blnAtualizar : Boolean;
begin
  Result := True;

  If (Sender = edtOuEnt) Then
  Begin
    If (fEmptyStr(edtOuEnt.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'O campo descrição deve ser preenchido!', ['&OK']);
      Result := False;
    End;
  End
  Else If (Sender = mskDtaEtr) Then
  Begin
    If (fEmptyStr(fTiraCaracEspeciais(mskDtaEtr.Text))) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de entrega deve ser preenchida!', ['&OK']);
      Result := False;
    End
    Else If (Not fValidaDataStr(mskDtaEtr.Text)) Then
    Begin
      fMensagem('ATENÇÃO!', 'Data Inválida!', ['&OK']);
      Result := False;
    End
    Else If (StrToDate(mskDtaEtr.Text) < VS_Date) Then
    Begin
      fMensagem('ATENÇÃO!', 'A data de entrega deve ser maior ou igual a data de hoje!', ['&OK']);
      Result := False;
    End;
  End
  Else If (Sender = edtCodReg) Then
  Begin
    If Not (fEmptyStr(edtCodReg.Text)) Then
    Begin
      edtDesReg.Text := fRetNomRegiao(edtCodReg.Text);
      If fEmptyStr(edtDesReg.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'Essa região não está cadastrada!', ['&OK']);
        Result := False;
      End;
    End
    Else
      edtDesReg.Text := EmptyStr;
  End
  Else If (Sender = edtPesBru) Then
  Begin
    If fEmptyStr(edtPesBru.Text) Then
      edtPesBru.Text := '0,00';

    if fStrToFloat(edtPesBru.Text) < 0 then
    begin
      fMensagem('', 'O peso total deve ser maior ou igual a 0!', ['&O k']);
      Result := False;
    end;
  End
  Else If (Sender = edtValDoc) Then
  Begin
    If fEmptyStr(edtValDoc.Text) Then
      edtValDoc.Text := '0,00';

    if fStrToFloat(edtValDoc.Text) < 0 then
    begin
      fMensagem('', 'O valor do documento deve ser maior ou igual a 0!', ['&O k']);
      Result := False;
    end;
  End
  Else
  If pnlEndereco.Visible Then
  Begin
    If (Sender = edtCodCid) Then
    Begin
      If Not fEmptyStr(edtCodCid.Text) Then
      Begin
        pCarregaCadCidade(edtCodCid.Text);
        If fEmptyStr(edtNomCid.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&Ok']);
          Result := False;
        End;
      End;
    End
    Else
    If (Sender = edtCodCli) Then
    Begin
      If Not fEmptyStr(edtCodCli.Text) Then
      Begin
        pCarregaEnderecoCliente(edtCodCli.Text);
        If Not fEmptyStr(edtCodCid.Text) Then
          pCarregaCadCidade(edtCodCid.Text);
      End;
    End
    Else If (Sender = edtCepCon) Then
    Begin

      If (Not fEmptyStr(fTiraCaracEspeciais(edtCepCon.Text))) Then
      Begin
        If Length(Trim(fTiraCaracEspeciais(edtCepCon.Text))) < 8 Then
        Begin
          fMensagem('ATENÇÃO!', 'O Cep deve ser vazio ou com 8 digitos.', ['&Ok']);
          Result := False;
        End;
      End;

      If (Result) And (fCfgSis('USACEP', varBoolean)) Then
      Begin
        If (Not fCadCepDadosCep(edtCepCon.Text,
                                strCodCid,
                                strEndere,
                                strBairro,
                                strNomCid,
                                strEstado,
                                LCodigoCorreio,
                                '',
                                '')) Then
          Begin
            Result := fMensagem('ATENÇÃO!', 'CEP não encontrado!' + #13 + 'Deseja continuar mesmo assim?', ['&Sim', '&Não'],2) = 1;
          End
          Else
          Begin

            If (fEmptyStr(strCodCid)) Then
            Begin

              If Not fEmptyStr(fRetNomCidade(edtCodCid.Text)) Then
              Begin

                If fMensagem('ATENÇÃO!', 'O Código Correios da cidade ' + edtNomCid.Text + ' está em branco.' + #13#10 +
                             'Deseja que o mesmo seja preenchido automaticamente no Cadastro de Cidades?', ['&Sim', '&Não']) = 1 Then
                Begin
                  pAtualizaCodigoCorreios(edtCodCid.Text, edtCepCon.Text);
                End
                Else
                  Result := False;

              End
              Else
              Begin
                fMensagem('ATENÇÃO!', 'Esse CEP não tem nenhum endereço associado no cadastro do AutCom.' + #13#10 +
                                      'Será aberto o Cadastro de Cidades para o preenchimento do Código Correios.', ['&Ok']);
                pCriarForm(TfrmCadCidades);

                Result := False;
              End;

            End

            {***********************************}
            {* CASO O CEP NÃO POSSUIR ENDERECO *}
            {********************************JB*}
            Else If (Not fEmptyStr(strNomCid)) And (fEmptyStr(strEndere)) Then
            Begin
              edtEndCon.Text := fTiraCaracEspeciais(strNomCid);
              strEndere      := edtEndCon.Text;
            End;

            If (Result) Then
            Begin

              blnAtualizar := False;
              If fTiraCaracEspeciais(strCepAnt) <> fTiraCaracEspeciais(edtCepCon.Text) Then
              Begin
                If fTiraCaracEspeciais(strCepAnt) = '' Then
                Begin
                  blnAtualizar := True;
                End
                Else
                If fMensagem('ATENÇÃO!', 'O CEP foi alterado, deseja atualizar o endereço?', ['&Sim', '&Não']) = 1 Then
                Begin
                  blnAtualizar := True;
                End

              End;

              If fEmptyStr(edtCodCid.Text) Or (blnAtualizar) Then
              Begin
                edtCodCid.Text := strCodCid;
                pCarregaCadCidade(edtCodCid.Text);
              End;

              If fEmptyStr(edtEndCon.Text) Or (blnAtualizar) Then
                edtEndCon.Text := strEndere;

              If fEmptyStr(edtBairro.Text) Or (blnAtualizar) Then
                edtBairro.Text := strBairro;

              If (strCodCid <> edtCodCid.Text) And (Not fEmptyStr(strCodCid)) Then
              Begin
                Result := False;
                pMensagemOk('O CEP informado não pertence a cidade de ' + fRetNomCidade(edtCodCid.Text) + '!');
              End;

            End;

          End;

          If (Result) Then
            strCepAnt := edtCepCon.Text;
      End;

    End;
  End;

  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmFatRomOutEntregas.pCarregaCadCidade(strCodCid: String);
var
  qryCadCid: TUniQuery;
begin

  qryCadCid := fCriaQuery(Self);
  try
    qryCadCid.Close;
    qryCadCid.SQL.Text :=
    ' SELECT '+
    '   CID_NOMCID, '+
    '   CID_ESTADO '+
    ' FROM '+
    '   CADCID '+
    ' WHERE '+
    '   CID_CODCID = :CODCID ';

    qryCadCid.ParamByName('CODCID').AsString := strCodCid;
    qryCadCid.Open;

    edtNomCid.Text := qryCadCid.FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := qryCadCid.FieldByName('CID_ESTADO').AsString;

    strCepAnt :=  edtCepCon.Text;

  finally
    FreeAndNil(qryCadCid);
  end;
end;

procedure TfrmFatRomOutEntregas.pCarregaEnderecoCliente(strCodCli: String);
var
  qryEndCli: TUniQuery;
begin

  qryEndCli := fCriaQuery(Self);
  try
    qryEndCli.Close;
    qryEndCli.SQL.Text :=
    ' SELECT '+
    '   CLI_ENDERE, '+
    '   CLI_BAIRRO, '+
    '   CLI_C_E_P_, '+
    '   CLI_CODCID '+
    ' FROM '+
    '   CADCLI '+
    ' WHERE '+
    '   CLI_CODCLI = :CODCLI ';

    qryEndCli.ParamByName('CODCLI').AsString := strCodCli;
    qryEndCli.Open;

    edtEndCon.Text := qryEndCli.FieldByName('CLI_ENDERE').AsString;
    edtBairro.Text := qryEndCli.FieldByName('CLI_BAIRRO').AsString;
    edtCepCon.Text := qryEndCli.FieldByName('CLI_C_E_P_').AsString;
    edtCodCid.Text := qryEndCli.FieldByName('CLI_CODCID').AsString;
  finally
    FreeAndNil(qryEndCli);
  end;

end;

end.
