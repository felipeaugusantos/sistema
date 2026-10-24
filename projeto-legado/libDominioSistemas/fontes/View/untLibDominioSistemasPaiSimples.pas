unit untLibDominioSistemasPaiSimples;
  
interface

uses
  Winapi.Windows, System.SysUtils, System.Types, System.Classes, System.Variants,
  Vcl.Forms, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Controls,
  Vcl.ExtCtrls, Vcl.Graphics, Vcl.Dialogs, Vcl.Mask, Vcl.AppEvnts,
  System.StrUtils,

  BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade, FilenameEditFocus,
  Uni,

  untLibDominioSistemasPai;

type
  TfrmPaiDominioSistemasSimples = class(TfrmPaiDominioSistemas)
    pgcDados: TPageControl;
    tbsGeral: TTabSheet;
    procedure FormShow(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mnuConfigurarRelClick(Sender: TObject);
  private
    { Private declarations }
  protected
    strNomeTabela: String;
    qryTabela: TUniQuery;
    procedure pInicializaIndices; virtual;
//    procedure pEscapePressed; virtual;

//    procedure pOnKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState); override;
//    procedure pOnKeyDownEdits(Sender: TObject; var Key: Word; Shift: TShiftState); override;
  public
    { Public declarations }
  end;

var
  frmPaiDominioSistemasSimples: TfrmPaiDominioSistemasSimples;

implementation

Uses untDominioSistemasFuncoes;

{$R *.dfm}

{ TfrmPaiDominioSistemasSimples }

procedure TfrmPaiDominioSistemasSimples.pInicializaIndices;
begin
  inherited;
  // Apenas para sobrescrever a procedure.....
end;

procedure TfrmPaiDominioSistemasSimples.FormShow(Sender: TObject);
begin
  // Apenas para sobrescrever a procedure.....
  If VS_FuncoesExternas.fIEhAdministrador(VS_FuncoesExternas.fIRetOperadorLogado) Then
    If fsModal In FormState Then
      VS_FuncoesExternas.fIRegistraCallStackSeEstiverEmTransacao(Nil, 'Formulário onde aconteceu: Name: '+Self.Name+' Caption: '+Self.Caption);
end;

procedure TfrmPaiDominioSistemasSimples.mnuConfigurarRelClick(Sender: TObject);
begin
  inherited;
  // nao remover este comentario, pois o evento deixara de funcionar
  // esta vinculado ao direito de acesso ao frmcadconfrelatorio
  // rl
end;

procedure TfrmPaiDominioSistemasSimples.btnSairClick(Sender: TObject);
begin
  Close;
end;

{procedure TfrmPaiDominioSistemasSimples.pOnKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    SelectNext(ActiveControl, True, True);
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;}

{procedure TfrmPaiDominioSistemasSimples.pOnKeyDownEdits(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  If (Key = VK_Return) Then
  Begin
    If (Sender As TWinControl).Tag = 99 Then
    Begin
      If (fValidaCampos(TWinControl(Sender))) And (blnMudarFoco) Then
        SelectNext(ActiveControl, True, True);
    End
    Else
      SelectNext(ActiveControl, True, True);
    blnMudarFoco := True;
  End
  Else If (Key = VK_Escape) Then
  Begin
    pEscapePressed;
  End;
end;}

//procedure TfrmPaiDominioSistemasSimples.pEscapePressed;
//begin
//  Close;
//end;

procedure TfrmPaiDominioSistemasSimples.btnCancelaClick(Sender: TObject);
begin
//  Close;
end;

procedure TfrmPaiDominioSistemasSimples.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  //
end;

end.

