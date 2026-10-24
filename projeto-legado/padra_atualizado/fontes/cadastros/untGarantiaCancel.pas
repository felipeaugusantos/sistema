unit untGarantiaCancel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Mask, MaskEditFocus,
  EditFocus, untGarant, Uni, AppEvnts, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmGarantiaCancel = class(TfrmPai)
    pnlDados: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    edtSenVen: TEditFocus;
    edtNomVen: TEditFocus;
    edtCodCli: TEditFocus;
    edtNomCli: TEditFocus;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    mskDtaEnt: TMaskEditFocus;
    pnlTopo: TPanel;
    Label1: TLabel;
    edtNumEnt: TEditFocus;
    btnConfirmar: TBitBtnLocked;
    procedure edtNumEntKeyPress(Sender: TObject; var Key: Char);
    procedure edtNumEntExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    objMovGag: TMovGag;
    procedure pLimpaDados;
    
  public
    { Public declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  end;

var
  frmGarantiaCancel: TfrmGarantiaCancel;

implementation

uses untfuncoesSimples, untConsultas, untTypesSistema;

{$R *.dfm}

procedure TfrmGarantiaCancel.edtNumEntKeyPress(Sender: TObject; var Key: Char);
  Var
    qryTmp      : TUniQuery;
    arrSel : TConsultasArray;

begin
  inherited;

    qryTmp := fCriaQuery;

    If fPesqGarnCanc(Self, edtNumEnt, qryTmp, Key, arrSel) Then
    Begin
      Self.SelectNext(ActiveControl, True, True);
    End;

    FreeAndNil(qryTmp);

end;

procedure TfrmGarantiaCancel.edtNumEntExit(Sender: TObject);
begin
  inherited;

  objMovGag.qryMovGag.Close;
  objMovGag.objMovGad.qryMovGad.Close;

  If Not fEmptyStr(edtNumEnt.Text) Then
  Begin

    objMovGag.pCarregaMovGag(edtNumEnt.Text);

    If fEmptyStr(objMovGag.strNumEnt) Then
    Begin

      fMensagem('ATENÇÃO!', 'Número de garantia não encontrado!', ['&Ok']);
      pSetFocus(edtNumEnt);
      pLimpaDados;
      Exit;

    End
    Else
    Begin

      mskDtaEnt.Text := FormatDateTime('dd/mm/yyyy', objMovGag.dtaDtaEnt);
      edtCodCli.Text := objMovGag.strCodCli;
      edtNomCli.Text := objMovGag.strNomCli;
      edtCodFor.Text := objMovGag.strCodFor;
      edtNomFor.Text := objMovGag.strNomFor;
      edtNomVen.Text := objMovGag.strNomVen;

      objMovGag.objMovGad.pCarregaMovGad(objMovGag.strAutInc);
      
    End;
  End;

end;

procedure TfrmGarantiaCancel.FormActivate(Sender: TObject);
begin
  inherited;

  pSetFocus(edtNumEnt);
end;

procedure TfrmGarantiaCancel.FormCreate(Sender: TObject);
begin
  inherited;

  objMovGag := TMovGag.Create(Self);
  edtNumEnt.TamCampo  := fTamDocCadRec;
  edtNumEnt.MaxLength := fTamDocCadRec;
end;

procedure TfrmGarantiaCancel.btnConfirmarClick(Sender: TObject);
begin
  inherited;

  If Not fEmptyStr(objMovGag.strNumEnt) Then
  Begin

    If fMensagem('','Deseja realmente excluir esta garantia?', ['&Sim','&Não']) = 1 Then
    Begin
      objMovGag.pCancelaGarantia;
      pLimpaDados;
      pSetFocus(edtNumEnt);
    End;

  End
  Else
    fMensagem('', 'Selecione uma garantia para ser cancelada!', ['&OK'])

end;

{**************************************}
{* LIMPA EDTS                         *}
{***********************************AF*}
procedure TfrmGarantiaCancel.pLimpaDados;
Begin
  mskDtaEnt.Clear;
  edtCodCli.Clear;
  edtNomCli.Clear;
  edtCodFor.Clear;
  edtNomFor.Clear;
End;


function TfrmGarantiaCancel.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
  Begin

    If (Sender = edtNumEnt) Then
    Begin

      if fEmptyStr(edtNumEnt.Text) Then
      Begin
        fMensagem('', 'Selecione uma garantia para ser cancelada!', ['&OK']);
        Result := False;
      End;
    
    End;

  End;

  If Not (Result) Then
    pSetFocus(Sender);

end;

end.

