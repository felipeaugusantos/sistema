unit untExpDigVolumes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, StdCtrls, EditFocus, frxClass, frxDBSet,
  AppEvnts, Menus, ComCtrls, Buttons, ExtCtrls,
  BitBtnLockedIncrem, frxExportCSVTestabilidade;

type
  TfrmExpDigVolumes = class(TfrmPaiConfirma)
    pnlFundo: TPanel;
    Label3: TLabel;
    chkEtiDes: TCheckBox;
    edtQtdVol: TEditFocus;
    lblPesBru: TLabel;
    edtPesBru: TEditFocus;
    lblPesLiq: TLabel;
    edtPesLiq: TEditFocus;
    edtEspTra: TEditFocus;
    Label5: TLabel;
    chkEtiDesVolComp: TCheckBox;
    pnlVolumeSepExc: TPanel;
    lblQtdVolSepExc: TLabel;
    edtQtdVolSepExc: TEditFocus;
    lblQtdVolSepNExc: TLabel;
    edtQtdVolSepNExc: TEditFocus;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  private
    { Private declarations }
  public
    intQtdVol : Integer;
    intQtdVolSepExc: Integer;
    intQtdVolSepNExc: Integer;
    fltPesBruOri: Double;
    fltPesLiqOri: Double;
    fltNovoPesBru: Double;
    fltNovoPesLiq: Double;
    blnImpEti : Boolean;
    strEspTra : String;
    function fValidarCampos(): Boolean;
    procedure pOnShow();
    { Public declarations }
  end;

var
  frmExpDigVolumes: TfrmExpDigVolumes;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmExpDigVolumes.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  inherited;
  If ModalResult = mrOk Then
    CanClose := fVerificaCampos
  Else
    CanClose := fPergunta('Deseja realmente cancelar?'+ sLineBreak +'As informações desta tela não serão consideradas.', False);
end;

procedure TfrmExpDigVolumes.FormCreate(Sender: TObject);
begin
  inherited;
  chkEtiDesVolComp.Visible := False;
  chkEtiDesVolComp.Checked := False;
end;

procedure TfrmExpDigVolumes.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If Key = VK_F10 Then
    btnConfirma.Click;
end;

procedure TfrmExpDigVolumes.FormShow(Sender: TObject);
begin
  inherited;
  pOnShow();
end;

procedure TfrmExpDigVolumes.pOnShow();
begin
  If fCfgSis('PESLIQ') <> 'SOMA' Then
  Begin
    lblPesLiq.Visible := False;
    edtPesLiq.Visible := False;
  End;

  pnlVolumeSepExc.Visible := fCfgSis('SEPEXC', varBoolean);
  If Not pnlVolumeSepExc.Visible Then
    Self.Height := Self.Height - pnlVolumeSepExc.Height;

  edtPesBru.Text := FloatToStrF(fltPesBruOri, ffNumber, 12, 3);
  edtPesLiq.Text := FloatToStrF(fltPesLiqOri, ffNumber, 12, 3);
  fltNovoPesBru := fltPesBruOri;
  fltNovoPesLiq := fltPesLiqOri;

  edtPesBru.Enabled := Not fCfgSis('TRPSEX', varBoolean);
  edtPesLiq.Enabled := edtPesBru.Enabled;
end;

function TfrmExpDigVolumes.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean = True): Boolean;
begin
  Result := True;
  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtQtdVol) Then
    Begin
      If fEmptyStr(edtQtdVol.Text) Then
      Begin
        fMensagem('ATENÇÃO!', 'É necessário informar a Quantidade de Volumes!', ['&Ok']);
        Result := False;
      End
      Else If fStrToFloat(edtQtdVol.Text) < 0 Then
      Begin
        fMensagem('ATENÇÃO!', 'Quantidade de Volumes não pode ser um número negativo!', ['&Ok']);
        Result := False;
      End
      Else
      Begin
        If pnlVolumeSepExc.Visible Then
        Begin
          edtQtdVolSepNExc.Text := FloatToStrF(fStrToFloat(edtQtdVol.Text) - fStrToFloat(edtQtdVolSepExc.Text), ffFixed, 12, 0);

          If fStrToFloat(edtQtdVolSepNExc.Text) < 0.0 Then
          Begin
            pMensagemOk('O campo "Volume dos itens de Separação não Exclusiva" não pode ficar negativo. '+
              'Ajuste o Volume para poder continuar (ele deve ser maior ou igual ao volume dos itens '+
              'de separação exclusiva) ou revise as configurações de cálculo de volume, pois o volume '+
              'dos itens de separação exclusiva devem seguir as configurações de cálculo de volume do Sistema.');
            Result := False;
          End;

          If fStrToFloat(edtQtdVol.Text) <> (fStrToFloat(edtQtdVolSepExc.Text) + fStrToFloat(edtQtdVolSepNExc.Text)) Then
          Begin
            pMensagemOk('O Volume deve ser igual à soma dos campos "Volume dos itens de Separação Exclusiva" e '+
              '"Volume dos itens de Separação Não Exclusiva". Realize o ajuste do campo do volume para poder continuar.');
            Result := False;
          End;
        End;
      End;

      If Result Then
      Begin
        intQtdVol := Trunc(fStrToFloat(edtQtdVol.Text));
        strEspTra := '';
        blnImpEti := chkEtiDes.Checked;

        If pnlVolumeSepExc.Visible Then
        Begin
          intQtdVolSepExc  := Trunc(fStrToFloat(edtQtdVolSepExc.Text));
          intQtdVolSepNExc := Trunc(fStrToFloat(edtQtdVolSepNExc.Text));
        End;
      End;
    End

    Else If (Sender = edtPesBru) And edtPesBru.Visible Then
    Begin
      If (fFormataFloat(fStrToFloat(edtPesBru.Text), 3) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O novo peso bruto não pode ser menor que 0 (Zero)!', ['&Ok']);
        Result := False;
      End
      Else If (Not edtPesLiq.Visible) And (Not edtEspTra.Visible) Then
      Begin
        intQtdVol := Trunc(fStrToFloat(edtQtdVol.Text));
        strEspTra := '';
        blnImpEti := chkEtiDes.Checked;
        fltNovoPesBru := fStrToFloat(edtPesBru.Text);
        fltNovoPesLiq := fStrToFloat(edtPesLiq.Text);

        If pnlVolumeSepExc.Visible Then
        Begin
          intQtdVolSepExc  := Trunc(fStrToFloat(edtQtdVolSepExc.Text));
          intQtdVolSepNExc := Trunc(fStrToFloat(edtQtdVolSepNExc.Text));
        End;
      End;
    End

    Else If (Sender = edtPesLiq) And edtPesLiq.Visible Then
    Begin
      If (fFormataFloat(fStrToFloat(edtPesLiq.Text), 3) < 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O novo peso liquido não pode ser menor que 0 (Zero)!', ['&Ok']);
        Result := False;
      End
      Else If (Not edtEspTra.Visible) Then
      Begin
        intQtdVol := Trunc(fStrToFloat(edtQtdVol.Text));
        strEspTra := '';
        blnImpEti := chkEtiDes.Checked;
        fltNovoPesBru := fStrToFloat(edtPesBru.Text);
        fltNovoPesLiq := fStrToFloat(edtPesLiq.Text);

        If pnlVolumeSepExc.Visible Then
        Begin
          intQtdVolSepExc  := Trunc(fStrToFloat(edtQtdVolSepExc.Text));
          intQtdVolSepNExc := Trunc(fStrToFloat(edtQtdVolSepNExc.Text));
        End;
      End;
    End

    Else If (Sender = edtEspTra) And edtEspTra.Visible Then
    Begin
      intQtdVol := Trunc(fStrToFloat(edtQtdVol.Text));
      strEspTra := edtEspTra.Text;
      blnImpEti := chkEtiDes.Checked;
      If (edtPesBru.Visible) Then
        fltNovoPesBru := fStrToFloat(edtPesBru.Text);
      If (edtPesLiq.Visible) Then
        fltNovoPesLiq := fStrToFloat(edtPesLiq.Text);

      If pnlVolumeSepExc.Visible Then
      Begin
        intQtdVolSepExc  := Trunc(fStrToFloat(edtQtdVolSepExc.Text));
        intQtdVolSepNExc := Trunc(fStrToFloat(edtQtdVolSepNExc.Text));
      End;
    End;

  End;

  If Not Result Then
    pSetFocus(Sender);

end;

function TfrmExpDigVolumes.fValidarCampos: Boolean;
begin
  Result := fVerificaCampos;
end;

procedure TfrmExpDigVolumes.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  if fEmptyStr(edtQtdVol.Text) Then
  Begin
    intQtdVol := 0;
    intQtdVolSepExc  := 0;
    intQtdVolSepNExc := 0;
    blnImpEti := False;
  End;
end;

end.
