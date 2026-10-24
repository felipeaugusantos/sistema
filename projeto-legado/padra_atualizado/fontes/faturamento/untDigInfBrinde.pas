unit untDigInfBrinde;

interface

uses
  SysUtils, Types, Classes, Variants, {QTypes,} Graphics, Controls, Forms, 
  Dialogs, StdCtrls, untPaiSimples, Menus, ComCtrls, Buttons,
  ExtCtrls, EditFocus, AppEvnts, BitBtnLockedIncrem,
  ComboBoxFocus, QColorLabel, frxClass, frxExportCSVTestabilidade;

type
  TfrmDigInfBrinde = class(TfrmPaiSimples)
    pnlConfirma: TPanel;
    btnCancelaDados: TBitBtnLocked;
    btnConfirmaDados: TBitBtnLocked;
    pnlParceiro: TPanel;
    Label3: TLabel;
    edtCodPar: TEditFocus;
    edtNomPar: TEditFocus;
    pnlTipBri: TPanel;
    Label5: TLabel;
    clbTipBri: TColorLabel;
    edtTipBri: TEditFocus;
    procedure btnCancelaClick(Sender: TObject);
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtCodParKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
    blnConfirma: Boolean;
  end;

  function fPedeDadosBrinde(blnBrinde: Boolean; Var strCodPar, strTipBri: String):Boolean;  

var
  frmDigInfBrinde: TfrmDigInfBrinde;

implementation

uses untPaiCad, untFuncoes, untfuncoesSimples, untConstantes, untConsultas,
  untTypesSistema;

{$R *.dfm}

procedure TfrmDigInfBrinde.btnCancelaClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmDigInfBrinde.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) And (fMensagem('','Confirma informações?', ['','']) = 1) Then
  Begin
    blnConfirma := True;
    Close;
  End;
end;

function TfrmDigInfBrinde.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  Try
    If (inherited fValidaCampos(Sender, blnBuscaPorChave)) Then
    Begin

      If (Sender = edtCodPar) And pnlParceiro.Visible Then
      Begin
        If Not fEmptyStr(edtCodPar.Text) Then
        Begin
          edtNomPar.Text := fRetNomeParceiro(edtCodPar.Text);
          If fEmptyStr(edtNomPar.Text) Then
          Begin
            fMensagem('','Nenhum parceiro cadastrado com este código!', ['&Ok']);
            Result := False;
          end;
        end
        Else
          edtNomPar.Clear;
      end

      Else If (Sender = edtTipBri) And pnlTipBri.Visible Then
      Begin
        If fEmptyStr(fTipoBrinde(edtTipBri.Text)) Then                          
        Begin
          fMensagem('','O Tipo de Brinde deve ser G, C, R, M, L!', ['&Ok']);
          Result := False;
        end;
      End;

    End;
  except
    On E: ExceptionAutcom Do
    Begin
      Result := False;
      fMensagem('', E.Message, ['&Ok']);
    End;

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, '');
    End;
  End;
  
  If Not Result Then
    pSetFocus(Sender);
end;

procedure TfrmDigInfBrinde.FormShow(Sender: TObject);
begin
  inherited;
  edtNomPar.Text := fRetNomeParceiro(edtCodPar.Text);

  If fEmptyStr(edtTipBri.Text) Then
    edtTipBri.Text := 'G';

  blnConfirma := (Not fEmptyStr(edtNomPar.Text));

  SelectFirst;
end;

procedure TfrmDigInfBrinde.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirma := False;
end;

procedure TfrmDigInfBrinde.edtCodParKeyPress(Sender: TObject;
  var Key: Char);
  Var
    arrParceiros: TConsultasArray;
begin
  inherited;
  If fPesqParceiro(Self, edtCodPar, edtNomPar, nil, Key, arrParceiros) Then
  Begin
    If fValidaCampos(edtCodPar, True) Then
      SelectNext(ActiveControl, True, True);
  End;
end;

function fPedeDadosBrinde(blnBrinde: Boolean; Var strCodPar, strTipBri: String):Boolean;
begin
  Result := True;

  If (Not fCfgSis('USAPAR', varBoolean)) Then Exit;

  If Not blnBrinde Then
  Begin
    strCodPar := '';
    strTipBri := '';
  End
  Else
  Begin
    Try
      pCriarFormularios(TfrmDigInfBrinde, frmDigInfBrinde);
      frmDigInfBrinde.edtCodPar.Text := strCodPar;
      frmDigInfBrinde.edtTipBri.Text := strTipBri;
      frmDigInfBrinde.ShowModal;
      Result := frmDigInfBrinde.blnConfirma;

      If Result Then
      Begin
        strCodPar := frmDigInfBrinde.edtCodPar.Text;
        strTipBri := frmDigInfBrinde.edtTipBri.Text;
      End;

    Except
      On E: Exception Do
      Begin
        Result := False;
        pMensagensErro('', E.Message, '');
      End;
    End;
    pFreeAndNil(frmDigInfBrinde);
  End;
end;

end.

