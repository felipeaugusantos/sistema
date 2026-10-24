unit untAltGlobCadCartoesAlt;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, EditFocus, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, cxGroupBox,
  cxRadioGroup;

type
  TfrmAltGlobCadCartoesAlt = class(TfrmPaiConfirma)
    gbClisiTef: TGroupBox;
    gbNcr: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtCAR_TFTRED: TEditFocus;
    edtCAR_TFTBAN: TEditFocus;
    edtCAR_TFRED2: TEditFocus;
    edtCAR_TFBAN2: TEditFocus;
    chkClisiTef: TCheckBox;
    chkNcr: TCheckBox;
    rdgCAR_STATUS: TcxRadioGroup;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    { Private declarations }
    FblnConfirma: Boolean ;
    FstrCAR_TFTRED: String;
    FstrCAR_TFTBAN: String;
    FstrCAR_STATUS: String;
    FstrCAR_TFRED2: String;
    FstrCAR_TFBAN2: String;
    FblnClisiTef: Boolean ;
    FblnNcr: Boolean ;
    function fVerificaInfoCampos: Boolean ;
  public
    { Public declarations }
    property Confirma: Boolean read FblnConfirma ;
    property CAR_TFTRED: String read FstrCAR_TFTRED ;
    property CAR_TFTBAN: String read FstrCAR_TFTBAN ;
    property CAR_STATUS: String read FstrCAR_STATUS ;
    property CAR_TFRED2: String read FstrCAR_TFRED2 ;
    property CAR_TFBAN2: String read FstrCAR_TFBAN2 ;
    property ClisiTefSelecionado: Boolean read FblnClisiTef;
    property NcrSelecionado: Boolean read FblnNcr;
  end;

implementation

uses untFuncoesSimples ;

{$R *.dfm}

procedure TfrmAltGlobCadCartoesAlt.btnConfirmaClick(Sender: TObject);
begin
  if not fVerificaInfoCampos then
  begin
    pSetFocus(edtCAR_TFTRED);
    exit ;
  end ;

  FstrCAR_STATUS := rdgCAR_STATUS.Properties.Items[rdgCAR_STATUS.ItemIndex].Value;

  FstrCAR_TFTRED := edtCAR_TFTRED.Text;
  FstrCAR_TFTBAN := edtCAR_TFTBAN.Text;
  FstrCAR_TFRED2 := edtCAR_TFRED2.Text;
  FstrCAR_TFBAN2 := edtCAR_TFBAN2.Text;

  FblnClisiTef := chkClisiTef.Checked ;
  FblnNcr := chkNcr.Checked ;

  FblnConfirma := True ;
  close ;
end;

procedure TfrmAltGlobCadCartoesAlt.FormCreate(Sender: TObject);
begin
  inherited;
  FstrCAR_TFTRED := '';
  FstrCAR_TFTBAN := '';
  FstrCAR_STATUS := '';
  FstrCAR_TFRED2 := '';
  FstrCAR_TFBAN2 := '';
  FblnClisiTef := False ;
  FblnNcr := False ;
  FblnConfirma := False ;
end;

procedure TfrmAltGlobCadCartoesAlt.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  If (Key = VK_Escape) And (Assigned(ActiveControl)) And (ActiveControl.Name = '') Then
  Begin
    Key := 0;
    btnSair.Click;
  End;

  Case Key Of
    VK_F10: btnConfirma.Click;
  End;
end;

function TfrmAltGlobCadCartoesAlt.fVerificaInfoCampos: Boolean;
var
  LblnTodosVazios: Boolean ;
  LstrMensagemTodosVazios: String ;
begin
  Result := True ;

  LstrMensagemTodosVazios := '' ;

  LblnTodosVazios := chkClisiTef.Checked and
                     fEmptyStr(edtCAR_TFTRED.Text) and
                     fEmptyStr(edtCAR_TFTBAN.Text) ;

  if LblnTodosVazios then
    LstrMensagemTodosVazios := LstrMensagemTodosVazios + 'A Informação de todas as colunas do ClisiTef serão limpas.'+#13 ;


  LblnTodosVazios := chkNcr.Checked and
                     fEmptyStr(edtCAR_TFRED2.Text) and
                     fEmptyStr(edtCAR_TFBAN2.Text) ;

  if LblnTodosVazios then
    LstrMensagemTodosVazios := LstrMensagemTodosVazios + 'A Informação de todas as colunas do ConexãoTech-Scope serão limpas.'+#13 ;


  if not fEmptyStr(LstrMensagemTodosVazios) then
    Result := fMensagem('',LstrMensagemTodosVazios + 'Deseja continuar?',['&Sim','&Não'], 2) = 1 ;

end;

end.
