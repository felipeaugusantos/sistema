unit untFatDigControleDataEntrega;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Mask,
  MaskEditFocus, EditFocus, QColorLabel, BitBtnLockedIncrem, Uni, frxClass,
  frxExportCSVTestabilidade;

type
  TfrmFatDigControleDataEntrega = class(TfrmPai)
    pnlCentro: TPanel;
    Label1: TLabel;
    mskPxDtEn: TMaskEditFocus;
    Label2: TLabel;
    edtPxPeEn: TEditFocus;
    clbEntrega: TColorLabel;
    btnConfirmaDados: TBitBtnLocked;
    procedure btnConfirmaDadosClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure pAtualizaDados;
    procedure pCarregaDados;
  protected
    function fValidaCampos(Sender: TWinControl; blnBuscaPorChave: Boolean = True): Boolean; override;
  public
    { Public declarations }
  end;

var
  frmFatDigControleDataEntrega: TfrmFatDigControleDataEntrega;

implementation

uses untFuncoesSimples;

{$R *.dfm}

{ TfrmFatDigControleDataEntrega }

procedure TfrmFatDigControleDataEntrega.btnConfirmaDadosClick(Sender: TObject);
begin
  inherited;
  If (fVerificaCampos) Then
  Begin
    pAtualizaDados;
    ModalResult := mrOk;
  End;
end;

procedure TfrmFatDigControleDataEntrega.FormShow(Sender: TObject);
begin
  inherited;
  pCarregaDados;
end;

function TfrmFatDigControleDataEntrega.fValidaCampos(Sender: TWinControl;
  blnBuscaPorChave: Boolean): Boolean;
begin
  Result := True;

  If (Sender = mskPxDtEn) Then
  Begin
    If (Not fEmptyStr(fTiraCaracEspeciais(mskPxDtEn.Text))) Then
    Begin
      edtPxPeEn.Enabled := True;
      If (StrToDateDef(mskPxDtEn.Text, 0) < VS_Date) Then
      Begin
        fMensagem('ATENÇÃO!', 'A próxima data de entrega deve ser maior ou igual à data atual.', ['&Ok']);
        Result := False;
      End;
    End
    Else
    Begin
      edtPxPeEn.Clear;
      edtPxPeEn.Enabled := False;
    End;
  End
  Else If (Sender = edtPxPeEn) Then
  Begin
    If (Not fEmptyStr(edtPxPeEn.Text)) Then
    Begin

      If (fEmptyStr(fTiraCaracEspeciais(mskPxDtEn.Text))) Then
      Begin
        fMensagem('ATENÇÃO!', 'Para informar o período, a próxima data de entrega deve ser preenchida.', ['&Ok']);
        Result := False;
      End
      Else If (Pos(edtPxPeEn.Text, 'MT') <= 0) Then
      Begin
        fMensagem('ATENÇÃO!', 'O período deve ser (M)anhã ou (T)arde.', ['&Ok']);
        Result := False;
      End
      Else If (StrToDateDef(mskPxDtEn.Text,0) = VS_Date) Then
      Begin
        If (edtPxPeEn.Text = 'M') And (fTime() > StrToTime('12:00:00')) Then
        Begin
          fMensagem('ATENÇÃO!', 'Neste momento, só é permitido informar o período da (T)arde.', ['&Ok']);
          Result := False;
        End;
      End;

    End;
  End;
end;

procedure TfrmFatDigControleDataEntrega.pAtualizaDados;
  Var
    qryAux: TUniQuery;
begin

  If fEmptyStr(fTiraCaracEspeciais(mskPxDtEn.Text)) Then
    Exit;

  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('UPDATE ');
  qryAux.SQL.Add('  CADEMP ');
  qryAux.SQL.Add('SET ');
  qryAux.SQL.Add('  EMP_PXDTEN = :PXDTEN, ');
  qryAux.SQL.Add('  EMP_PXPEEN = :PXPEEN ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  EMP_CODEMP = :CODEMP ');

  qryAux.ParamByName('PXDTEN').AsDateTime := StrToDate(mskPxDtEn.Text);
  qryAux.ParamByName('PXPEEN').AsString   := edtPxPeEn.Text;

  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.ExecSQL;

  FreeAndNil(qryAux);
end;

procedure TfrmFatDigControleDataEntrega.pCarregaDados;
  Var
    qryAux: TUniQuery;
begin
  qryAux := fCriaQuery(Self);
  qryAux.SQL.Add('SELECT ');
  qryAux.SQL.Add('  EMP_PXDTEN, ');
  qryAux.SQL.Add('  EMP_PXPEEN ');
  qryAux.SQL.Add('FROM ');
  qryAux.SQL.Add('  CADEMP ');
  qryAux.SQL.Add('WHERE ');
  qryAux.SQL.Add('  EMP_CODEMP = :CODEMP ');

  qryAux.ParamByName('CODEMP').AsString := VS_strCodEmp;
  qryAux.Open;

  If (Not fEmptyStr(qryAux.FieldByName('EMP_PXDTEN').AsString)) Then
    mskPxDtEn.Text := qryAux.FieldByName('EMP_PXDTEN').AsString;

  If (Not fEmptyStr(qryAux.FieldByName('EMP_PXPEEN').AsString)) Then
    edtPxPeEn.Text := qryAux.FieldByName('EMP_PXPEEN').AsString;

  FreeAndNil(qryAux);

  If (Not fEmptyStr(fTiraCaracEspeciais(mskPxDtEn.Text))) Then
  Begin
    edtPxPeEn.Enabled := True;
  End;
end;

end.
