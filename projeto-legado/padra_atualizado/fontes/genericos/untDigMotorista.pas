unit untDigMotorista;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPai, AppEvnts, Menus,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, EditFocus, Mask,
  MaskEditFocus, Uni, frxClass, frxExportCSVTestabilidade, Data.DB, Vcl.Grids,
  Vcl.DBGrids, DBGridCitel, Datasnap.DBClient, UniClientDataSet;

type
  TfrmDigMotorista = class(TfrmPai)
    pnlCentral: TPanel;
    lblMotorista: TLabel;
    edtCodMot: TEditFocus;
    edtNomMot: TEditFocus;
    btnGravar: TBitBtnLocked;
    lbl16: TLabel;
    mskPlaVei: TMaskEditFocus;
    edtMarVei: TEditFocus;
    edtModVei: TEditFocus;
    btnAdicionaItem: TBitBtnLocked;
    cdsGrid: TUniClientDataSet;
    dsGrid: TDataSource;
    dbgItens: TDBGridCitel;
    cdsGridMOT_CODMOT: TStringField;
    cdsGridMOT_NOMMOT: TStringField;
    cdsGridMOT_CPFMOT: TStringField;
    chkReboque: TCheckBox;
    lblPlacaReboque: TLabel;
    mskPlaVeiReboque: TMaskEditFocus;
    edtMarVeiReboque: TEditFocus;
    edtModVeiReboque: TEditFocus;
    procedure edtCodMotKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
    procedure btnAdicionaItemClick(Sender: TObject);
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodMotExit(Sender: TObject);
    procedure mskPlaVeiReboqueKeyPress(Sender: TObject; var Key: Char);
    procedure chkReboqueClick(Sender: TObject);
  private
    function fCarregaCadMot: Boolean;
    procedure pRetornaDadosVeiculo(strPlaca: String; var strMarca, strModelo,
                           strTipoRodado, strTipoCarroceria: String;
                           var intCapacidadeKg, intTaraKg: Integer);
    function fMotoristaCpfPreenchido(const strCodMot: String): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnObrigatorio: Boolean;
  end;

var
  frmDigMotorista: TfrmDigMotorista;

implementation

{$R *.dfm}

uses untConsultas, untFuncoesSimples, untTypesSistema;

procedure TfrmDigMotorista.btnAdicionaItemClick(Sender: TObject);
var
  strCpfMotorista: String;
begin
  inherited;

  If (fEmptyStr(edtCodMot.Text)) Then
  Begin
    pSetFocus(edtCodMot);
    Exit;
  End;

  If Not fValidaCampos(edtCodMot, True) Then
    Exit;

  if cdsGrid.RecordCount = 10 then
  begin
    fMensagem('ATENÇÃO!', 'São permitidos no máximo 10 motoristas!', ['&O k']);
    Exit;
  end;

  cdsGrid.DisableControls;
  try
    cdsGrid.First;
    While Not cdsGrid.Eof Do
    Begin
      if cdsGrid.FieldByName('MOT_CODMOT').AsString = edtCodMot.Text then
      begin
        fMensagem('ATENÇÃO!', 'Este motorista já foi incluso!', ['&O k']);
        pSetFocus(edtCodMot);
        Exit;
      end;

      cdsGrid.Next;
    End;
  finally
    cdsGrid.EnableControls;
  end;

  strCpfMotorista := fCampoTabela('MOT_CPFMOT','CADMOT', ['MOT_CODMOT'], [edtCodMot.Text], False);

  cdsGrid.DisableControls;
  try
    cdsGrid.First;
    While Not cdsGrid.Eof Do
    Begin
      if cdsGrid.FieldByName('MOT_CPFMOT').AsString = strCpfMotorista then
      begin
        fMensagem('ATENÇÃO!', 'Já existe um motorista com o mesmo CPF!', ['&O k']);
        pSetFocus(edtCodMot);
        Exit;
      end;

      cdsGrid.Next;
    End;
  finally
    cdsGrid.EnableControls;
  end;

  cdsGrid.Insert;
  cdsGrid.FieldByName('MOT_CODMOT').AsString := edtCodMot.Text;
  cdsGrid.FieldByName('MOT_NOMMOT').AsString := edtNomMot.Text;
  cdsGrid.FieldByName('MOT_CPFMOT').AsString := strCpfMotorista;
  cdsGrid.Post;

  edtCodMot.Text := EmptyStr;
  edtNomMot.Text := EmptyStr;
  pSetFocus(edtCodMot);
end;

procedure TfrmDigMotorista.btnGravarClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    ModalResult := mrOk;
  End;
end;

procedure TfrmDigMotorista.chkReboqueClick(Sender: TObject);
begin
  inherited;
  lblPlacaReboque.Enabled := chkReboque.Checked;
  mskPlaVeiReboque.Enabled := lblPlacaReboque.Enabled;
end;

procedure TfrmDigMotorista.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_DELETE) And (cdsGrid.Active) And (Not cdsGrid.IsEmpty) Then
    cdsGrid.Delete;
end;

procedure TfrmDigMotorista.edtCodMotExit(Sender: TObject);
begin
  inherited;
  if fEmptyStr(edtCodMot.Text) Then
  Begin
    edtNomMot.Clear;
    pSetFocus(btnGravar);
  End;
end;

procedure TfrmDigMotorista.edtCodMotKeyPress(Sender: TObject; var Key: Char);
  Var
    arrMot: TConsultasArray;
begin
  inherited;
  {*******************************}
  {* NOVA CONSULTA DE MOTORISTAS *}
  {****************************RV*}
  If fPesqMotorista(Self, edtCodMot, edtNomMot, Nil, Key, arrMot) Then
  Begin
    If fValidaCampos(edtCodMot, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigMotorista.FormCreate(Sender: TObject);
begin
  inherited;
  blnObrigatorio := False;
end;

procedure TfrmDigMotorista.FormShow(Sender: TObject);
begin
  inherited;
  cdsGrid.Close;
  cdsGrid.CreateDataSet;
  cdsGrid.Open;

  pSetFocus(mskPlaVei);
end;

function TfrmDigMotorista.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
  Var
    strMarca, strModelo: String;
    strTipoRodado: string;
    strTipoCarroceria: string;
    intCapacidadeKg: Integer;
    intTaraKg: Integer;
begin
  Result := True;

  If (Sender = edtCodMot) Then
  Begin

    If not blnBuscaPorChave and blnObrigatorio and cdsGrid.IsEmpty Then
    Begin
      fMensagem('ATENÇÃO!', 'Pelo menos um Motorista deve ser preenchido!', ['&Ok']);
      Result := False;
    End
    Else
    Begin
      If (fEmptyStr(edtCodMot.Text)) Then
        edtNomMot.Clear
      else
      If Not (fCarregaCadMot) Then
      Begin
        fMensagem('ATENÇÃO!', 'Esse Motorista está inativo!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If fEmptyStr(edtNomMot.Text) Then
        Begin
          fMensagem('ATENÇÃO!', 'Esse Motorista não está cadastrado!', ['&Ok']);
          Result := False;
        End
        Else
        If (Not fMotoristaCpfPreenchido(edtCodMot.Text)) Then
        Begin
          fMensagem('ATENÇÃO!', 'Este Motorista não está com o CPF preenchido!', ['&Ok']);
          Result := False;
        End;
      End;
    End;

  End
  Else If (Sender = mskPlaVei) Then
  Begin

    If fVeiculoInativo(mskPlaVei.Text) Then
    Begin
      edtMarVei.Clear;
      edtModVei.Clear;
      fMensagem('','Este veículo está inativo.',['&O k']);
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(mskPlaVei.Text) Then
      Begin
        pMensagemOk('A placa do veículo deve ser preenchida.');
        Result := False;
      End
      Else
      Begin
        pRetornaDadosVeiculo(mskPlaVei.Text, strMarca, strModelo, strTipoRodado, strTipoCarroceria, intCapacidadeKg, intTaraKg);
        If fEmptyStr(strMarca) And fEmptyStr(strModelo) Then
        Begin
          pMensagemOk('Este veículo não está cadastrado.');
          Result := False;
        End
        Else
        Begin
          if (fEmptyStr(strTipoRodado)) then
          begin
            pMensagemOk('O Tipo de Rodado é obrigatório, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else if (fEmptyStr(strTipoCarroceria)) then
          begin
            pMensagemOk('O Tipo de Carroceria é obrigatório, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else
          begin
            edtMarVei.Text := strMarca;
            edtModVei.Text := strModelo;
          end;
        End;
      End;
    End;
  End
  Else If (chkReboque.Checked) and (Sender = mskPlaVeiReboque) Then
  Begin

    If fVeiculoInativo(mskPlaVeiReboque.Text) Then
    Begin
      edtMarVeiReboque.Clear;
      edtModVeiReboque.Clear;
      fMensagem('','Este veículo está inativo.',['&O k']);
      Result := False;
    End
    Else
    Begin
      If fEmptyStr(mskPlaVeiReboque.Text) Then
      Begin
        pMensagemOk('A placa do veículo deve ser preenchida.');
        Result := False;
      End
      Else
      Begin
        pRetornaDadosVeiculo(mskPlaVeiReboque.Text, strMarca, strModelo, strTipoRodado, strTipoCarroceria, intCapacidadeKg, intTaraKg);
        If fEmptyStr(strMarca) And fEmptyStr(strModelo) Then
        Begin
          pMensagemOk('Este veículo não está cadastrado.');
          Result := False;
        End
        Else
        Begin
          if (intTaraKg <= 0) then
          begin
            pMensagemOk('A Tara (Kg) é obrigatória, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else if (intCapacidadeKg <= 0) then
          begin
            pMensagemOk('A Capacidade (KG) é obrigatória, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else if (fEmptyStr(strTipoRodado)) then
          begin
            pMensagemOk('O Tipo de Rodado é obrigatório, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else if (fEmptyStr(strTipoCarroceria)) then
          begin
            pMensagemOk('O Tipo de Carroceria é obrigatório, corrija no Cadastro de Veículos.');
            Result := False;
          end
          else
          begin
            edtMarVeiReboque.Text := strMarca;
            edtModVeiReboque.Text := strModelo;
          end;
        End;
      End;
    End;
  End;
end;

procedure TfrmDigMotorista.pRetornaDadosVeiculo(strPlaca: String; Var strMarca, strModelo,
                           strTipoRodado, strTipoCarroceria: String;
                           var intCapacidadeKg, intTaraKg: Integer);
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  MAR_DESMAR, ');
  qryAux.SQL.Add('  MOD_DESMOD, ');
  qryAux.SQL.Add('  VEI_CAPCAR, ');
  qryAux.SQL.Add('  VEI_TARAKG, ');
  qryAux.SQL.Add('  VEI_TIPROD, ');
  qryAux.SQL.Add('  VEI_TPCARR ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADVEI ');
  qryAux.SQL.Add('  JOIN MARVEI ON MAR_CODMAR = VEI_CODMAR ');
  qryAux.SQL.Add('  JOIN MODVEI ON MOD_CODMOD = VEI_CODMOD ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  VEI_PLAVEI = :PLACA ');

  qryAux.ParamByName('PLACA').AsString := strPlaca;
  qryAux.Open;

  strMarca := qryAux.FieldByName('MAR_DESMAR').AsString;
  strModelo := qryAux.FieldByName('MOD_DESMOD').AsString;
  strTipoRodado := qryAux.FieldByName('VEI_TIPROD').AsString;
  strTipoCarroceria := qryAux.FieldByName('VEI_TPCARR').AsString;
  intCapacidadeKg := qryAux.FieldByName('VEI_CAPCAR').AsInteger;
  intTaraKg := qryAux.FieldByName('VEI_TARAKG').AsInteger;

  FreeAndNil(qryAux);
end;

procedure TfrmDigMotorista.mskPlaVeiKeyPress(Sender: TObject; var Key: Char);
  Var
    arrVei: TConsultasArray;
begin
  inherited;
  {*****************************}
  {* NOVA CONSULTA DE VEICULOS *}
  {**************************MM*}
  If fPesqVeiculos(Self, mskPlaVei, nil, Nil, Key, arrVei, True, False,  ' VEI_STATUS = "A" AND VEI_REBOQU = "N" ') Then
  Begin
    If fValidaCampos(mskPlaVei, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmDigMotorista.mskPlaVeiReboqueKeyPress(Sender: TObject; var Key: Char);
var
  arrVei: TConsultasArray;
begin
  inherited;
  If fPesqVeiculos(Self, mskPlaVeiReboque, nil, Nil, Key, arrVei, True, False,  ' VEI_STATUS = "A" AND VEI_REBOQU = "S" ') Then
  Begin
    If fValidaCampos(mskPlaVeiReboque, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function TfrmDigMotorista.fCarregaCadMot: Boolean;
begin
  If Not fEmptyStr(edtCodMot.Text) Then
  Begin
    if (fRetStatusMotorista(edtCodMot.Text) = 'I') Then
    Begin
      Result := False;
      Exit;
    End
    Else
      edtNomMot.Text := fRetNomeMotorista(edtCodMot.Text);
  End
  Else
    edtNomMot.Clear;

  Result := True;
end;

function TfrmDigMotorista.fMotoristaCpfPreenchido(const strCodMot: String): Boolean;
begin
  Result := (Not fEmptyStr(fCampoTabela('MOT_CPFMOT','CADMOT', ['MOT_CODMOT'], [strCodMot], False)));
end;

end.
