unit untCadAnaliseMovFinal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiEdit, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, Vcl.ExtCtrls, untFuncoesSimples, untAnaliseMov;

type
  TfrmCadAnaliseMovFinal = class(TfrmPaiEdit)
    btnGravar: TBitBtnLocked;
    Panel1: TPanel;
    gpbLiberacao: TGroupBox;
    chkFinAna: TCheckBox;
    rdgStatus: TGroupBox;
    rdbAprovado: TRadioButton;
    rdbReprovado: TRadioButton;
    rdbCorrecao: TRadioButton;
    gpbAcompanhamento: TGroupBox;
    rdgStaAco: TGroupBox;
    rdbAcoAprovado: TRadioButton;
    rdbAcoReprovado: TRadioButton;
    rdbAcoCorrecao: TRadioButton;
    chkFinAco: TCheckBox;
    rdbAprCorrecao: TRadioButton;
    rdbAcoAprCorrecao: TRadioButton;
    procedure chkFinAnaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure chkFinAcoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    blnPerFsa: Boolean;
  public
    objAnaMov: TAnaliseMov;
    strSeqAna: String;
  end;



implementation

{$R *.dfm}

procedure TfrmCadAnaliseMovFinal.chkFinAcoClick(Sender: TObject);
begin
  inherited;

  rdgStaAco.Enabled := chkFinAco.Checked;

  If Not chkFinAco.Checked Then
  Begin
    rdbAcoAprovado.Checked := False;
    rdbAcoReprovado.Checked := False;
    rdbAcoCorrecao.Checked := False;
  End;
end;

procedure TfrmCadAnaliseMovFinal.chkFinAnaClick(Sender: TObject);
begin
  inherited;

  rdgStatus.Enabled := chkFinAna.Checked;

  If Not chkFinAna.Checked Then
  Begin
    rdbAprovado.Checked := False;
    rdbReprovado.Checked := False;
    rdbCorrecao.Checked := False;
  End;

  gpbAcompanhamento.Enabled := chkFinAna.Checked;
end;


procedure TfrmCadAnaliseMovFinal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin

    If gpbLiberacao.Enabled Then
    Begin
      If chkFinAna.Checked And
         (Not rdbAprovado.Checked) And
         (Not rdbReprovado.Checked) And
         (Not rdbCorrecao.Checked) And
         ((Not blnPerFsa) And (Not rdbAprCorrecao.Checked)) Then
      Begin
        pMensagemOk('Escolha a Situação para a Liberação do Lote!');
        Action := caNone;
        Exit;
      End;

      If chkFinAna.Checked And objAnaMov.fTemAnaliseVencida(INT_APROVACAO) Then
      Begin
        Action := caNone;
        Exit;
      End;

      If (Not blnPerFsa) And (objAnaMov.fTemAnaliseSemSituacaoOuSituacaoVazia(INT_APROVACAO)) Then
      Begin
        If Not objAnaMov.fLiberaAnaliseSemSituacaoOuSituacaoVazia(strSeqAna) Then
        Begin
          Action := caNone;
          Exit;
        End;
      End;

    End;

    If gpbAcompanhamento.Enabled Then
    Begin
      If chkFinAco.Checked And
         (Not rdbAcoAprovado.Checked) And
         (Not rdbAcoReprovado.Checked) And
         (Not rdbAcoCorrecao.Checked) And
         ((Not blnPerFsa) And (Not rdbAcoAprCorrecao.Checked)) Then
      Begin
        pMensagemOk('Escolha a Situação para o Acompanhamento do Lote!');
        Action := caNone;
        Exit;
      End;

      If chkFinAco.Checked And objAnaMov.fTemAnaliseVencida(INT_ACOMPANHAMENTO) Then
      Begin
        Action := caNone;
        Exit;
      End;

    End;

  End;
end;

procedure TfrmCadAnaliseMovFinal.FormCreate(Sender: TObject);
begin
  inherited;

  blnPerFsa := fCfgSis('PERFSA', varBoolean);
end;

procedure TfrmCadAnaliseMovFinal.FormShow(Sender: TObject);
begin
  inherited;

  gpbAcompanhamento.Enabled := chkFinAna.Checked;

  rdbAprCorrecao.Visible    := rdbAprCorrecao.Visible And (Not blnPerFsa);
  rdbAcoAprCorrecao.Visible := rdbAcoAprCorrecao.Visible And (Not blnPerFsa);
end;

end.
