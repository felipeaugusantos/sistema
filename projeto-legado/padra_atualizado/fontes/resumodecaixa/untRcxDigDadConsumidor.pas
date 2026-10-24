unit untRcxDigDadConsumidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxLookAndFeels,
  cxLookAndFeelPainters, Vcl.Menus,
  Vcl.Mask, MaskEditFocus, Vcl.StdCtrls, EditFocus, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Buttons, BitBtnLockedIncrem,
  Vcl.ExtCtrls, Uni;

type
  TfrmRcxDigDadConsumidor = class(TfrmPai)
    pnlFundo: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    lblIncEst: TLabel;
    lblRg: TLabel;
    lbl1: TLabel;
    Label4: TLabel;
    edtNomCli: TEditFocus;
    edtEndere: TEditFocus;
    edtBairro: TEditFocus;
    mskTelCon: TMaskEditFocus;
    mskNumCep: TMaskEditFocus;
    edtCgcCpf: TEditFocus;
    edtInsEst: TEditFocus;
    edtEstado: TEditFocus;
    edtRgCli: TEditFocus;
    mskNumCgc: TMaskEditFocus;
    edtEmail: TEditFocus;
    edtCodCid: TEditFocus;
    edtNomCid: TEditFocus;
    btnConfirma: TbitBtnLocked;
    procedure edtCgcCpfChange(Sender: TObject);
    procedure edtCgcCpfExit(Sender: TObject);
    procedure mskNumCgcKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodCidKeyPress(Sender: TObject; var Key: Char);
    procedure mskNumCepKeyPress(Sender: TObject; var Key: Char);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    strEstadoIni: String;
    qryConCid: TUniQuery;
    qryCliCon: TUniQuery;
    procedure pCarregaCidade;
    function fValidaCnpjCpf(strOpcao, strValor: String; blnPassaVazio: Boolean = True; blnPermiteDigitosIguais: Boolean = False): Boolean;
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    blnConfirma: Boolean;
    strCodCli  : String;
    { Public declarations }
  end;

var
  frmRcxDigDadConsumidor: TfrmRcxDigDadConsumidor;

implementation

{$R *.dfm}

uses untConsultas, untTypesSistema, untFuncoesSimples, untCadCid, untPesqAux,
     untFuncoesGenerica;

procedure TfrmRcxDigDadConsumidor.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  If fVerificaCampos Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

procedure TfrmRcxDigDadConsumidor.edtCgcCpfChange(Sender: TObject);
begin
  inherited;
  If edtCgcCpf.Text = '1' Then
  Begin
    edtRgCli.Clear;
    edtRgCli.Enabled := False;
    edtRgCli.Visible := False;
    lblRg.Visible    := False;

    edtInsEst.Enabled := True;
    edtInsEst.Visible := True;
    edtInsEst.Left    := 102;
    edtInsEst.Width   := 173;
    lblIncEst.Visible := True;
    lblIncEst.Left    := 9;
  End
  Else
  Begin
    edtInsEst.Clear;
    edtInsEst.Enabled := False;
    edtInsEst.Visible := False;
    lblIncEst.Visible := False;

    edtRgCli.Enabled := True;
    edtRgCli.Visible := True;
    edtRgCli.Left    := 102;
    edtRgCli.Width   := 173;
    lblRg.Visible    := True;
    lblRg.Left       := 82;
  End;
end;

procedure TfrmRcxDigDadConsumidor.edtCgcCpfExit(Sender: TObject);
begin
  inherited;
  If (edtCgcCpf.Text = '1') Then
    mskNumCgc.EditMask := fRetMascaraC_G_C_(fSetaPais, C_G_C_)
  Else
    mskNumCgc.EditMask := '999.999.999-99;0;';
end;

procedure TfrmRcxDigDadConsumidor.edtCodCidKeyPress(Sender: TObject; var Key: Char);
  Var
    arrCidade: TConsultasArray;
begin
  inherited;
  {****************************}
  {* NOVA CONSULTA DE CIDADES *}
  {*************************RV*}
  If fPesqCidade(Self, edtCodCid, edtNomCid, edtEstado, Nil, Key, arrCidade) Then
  Begin
    If fValidaCampos(edtCodCid) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

procedure TfrmRcxDigDadConsumidor.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
  qryConCid   := fCriarQuery('SELECT * FROM CADCID WHERE FALSE', Self);
  qryCliCon   := fCriarQuery('SELECT * FROM CLICON WHERE FALSE', Self);
end;

procedure TfrmRcxDigDadConsumidor.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(edtNomCli);

  strEstadoIni := edtEstado.Text;

  edtCgcCpfExit(Nil);
end;

function TfrmRcxDigDadConsumidor.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNomCli) Then
    Begin
      If fEmptyStr(edtNomCli.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Nome deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtEndere) Then
    Begin
      If fEmptyStr(edtEndere.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Endereço deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If Length(edtEndere.Text) < 2 Then
      Begin
        fMensagem('ATENÇÃO', 'O Endereço deve conter no mínimo 2 dígitos!', ['&O k']);
        Result := False;
      End
    End

    Else If (Sender = edtBairro) Then
    Begin
      If fEmptyStr(edtBairro.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O Bairro deve ser preenchido!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCodCid) Then
    Begin

      If fEmptyStr(edtCodCid.Text) Then
      Begin
        edtNomCid.Clear;
        edtEstado.Clear;
        fMensagem('ATENÇÃO!', 'A cidade deve ser preenchida!', ['&O k']);
        Result := False;
      End
      Else
      Begin
        pCarregaCidade;
        If qryConCid.FieldByName('CID_CODCID').IsNull Then
        Begin
          fMensagem('ATENÇÃO!', 'Essa cidade não está cadastrada!', ['&O k']);
          Result := False;
        End

        Else If Not fValidaEstado(qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO!', 'Estado inválido!', ['&O k']);
          Result := False;
        End

        Else If qryConCid.FieldByName('CID_ESTADO').AsString <> strEstadoIni Then
        Begin
          fMensagem('ATENÇÃO!', 'Estado diferente do Estado do cliente consumidor!', ['&O k']);
          Result := False;
        End
      End;

    End

    Else If (Sender = mskNumCep) Then
    Begin

      If fEmptyStr(mskNumCep.Text) Then
      Begin
        fMensagem('ATENÇÃO', 'O CEP deve ser preenchido!', ['&O k']);
        Result := False;
      End
      Else If (Length(mskNumCep.Text) < 8) Then
      Begin
        fMensagem('ATENÇÃO', 'O CEP deve conter 8 digitos!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = edtCgcCpf) Then
    Begin
      If (edtCgcCpf.Text <> '1') And (edtCgcCpf.Text <> '2') Then
      Begin
        fMensagem('ATENÇÃO', 'O campo CGC/CPF deve ser 1 ou 2!', ['&O k']);
        Result := False;
      End;
    End

    Else If (Sender = mskNumCgc) Then
    Begin
      If (fCfgSis('OBCFCC', varBoolean) and (fEmptyStr(mskNumCgc.Text))) Then
      Begin
        if not(fCfgSis('AUTCEN', VarBoolean)) then
        begin
          fMensagem('','O campo CPF/CNPJ deve ser preenchido!', ['&Ok']);
          Result := False;
        end;
      End;

      If fEmptyStr(mskNumCgc.Text) Then
      Begin
        If (fCfgSis('CPFOBR', varBoolean)) Then
          Result := False;
      End
      Else
      Begin
        if fCfgSis('OBCFCC', varBoolean) then
          Result := untFuncoesSimples.fValidaCnpjCpf(mskNumCgc.Text, True)
        else
          Result := fValidaCnpjCpf(edtCgcCpf.Text, mskNumCgc.Text, False, True);
      End;
    End

    Else If (Sender = edtInsEst) And (edtInsEst.Visible) Then
    Begin
      pCarregaCidade;
      If (Not fEmptyStr(edtInsEst.Text))                  And
         (Not qryConCid.FieldByName('CID_CODCID').IsNull) Then
      Begin
        If Not fValidaIES(edtInsEst.Text, qryConCid.FieldByName('CID_ESTADO').AsString) Then
        Begin
          fMensagem('ATENÇÃO', edtInsEst.Text + ' não é uma Inscrição Estadual válida!', ['&O k']);
          Result := False;
        End
        Else
        Begin
          If qryConCid.FieldByName('CID_ESTADO').AsString = 'RS' Then
          Begin
            edtInsEst.Text := fRetornaZerosNumIes(edtInsEst.Text) + edtInsEst.Text;
          End;
        End;
      End
      Else
        edtInsEst.Clear;
    End

    Else If (Sender = mskTelCon) Then
    Begin
      If fCfgSis('OBTLCC', varBoolean) Then
      Begin
        If (fEmptyStr(mskTelCon.Text)) Then
        Begin
          fMensagem('','O campo Telefone deve ser preenchido!', ['&Ok']);
          Result := False;
        End

        Else If (Not fValidaTelefone(mskTelCon.Text)) Then
        Begin
           fMensagem('','Informe o Telefone corretamente!', ['&Ok']);
           Result := False;
        End;
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmRcxDigDadConsumidor.fValidaCnpjCpf(strOpcao, strValor: String;
  blnPassaVazio, blnPermiteDigitosIguais: Boolean): Boolean;
begin
  Result := True;
  If (blnPassaVazio) And (strOpcao = '0') Then
    Exit;

  If strOpcao = '1' Then
  Begin
    Result := fTestaCgc(strValor);
    If Not Result Then
      fMensagem('ATENÇÃO', strValor + ' não é um Número de CNPJ válido!', ['&O k']);
  End
  Else If strOpcao = '2' Then
  Begin
    Result := fValidaCPF(strValor);
    If Not Result Then
      fMensagem('ATENÇÃO', strValor + ' não é um Número de CPF válido!', ['&O k']);
  End;

end;

procedure TfrmRcxDigDadConsumidor.mskNumCepKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (fEntraCons(Key)) And (fCfgSis('USACEP', varBoolean)) Then
  Begin
   Key := #0;

    mskNumCep.Text := fConsultarCep(Self,
                                    mskNumCep.Text,
                                    mskNumCep,
                                    edtEstado.Text,
                                    fRetCodCorreio(edtCodCid.Text),
                                    edtNomCid.Text);
  End;
end;

procedure TfrmRcxDigDadConsumidor.mskNumCgcKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  If (edtCgcCpf.Text = '0') Or (fEmptyStr(edtCgcCpf.Text)) Then
    Key := #0;
end;

procedure TfrmRcxDigDadConsumidor.pCarregaCidade;
begin
  pPesquisaCadCid(qryConCid, qryConCid, edtCodCid.Text);
  With qryConCid Do
  Begin
    edtNomCid.Text := FieldByName('CID_NOMCID').AsString;
    edtEstado.Text := FieldByName('CID_ESTADO').AsString;

    If fEmptyStr(mskNumCep.Text) Then
    Begin
      mskNumCep.Text := FieldByName('CID_C_E_P_').AsString;
    End;

  End;
end;

end.
