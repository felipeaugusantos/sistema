unit untNumeroDrawbackFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, EditFocus,
  Vcl.ExtCtrls, untFuncFat, untConstantes, Vcl.Buttons, BitBtnLockedIncrem,
  untTypesSistema;

type

  TfraNumeroDrawbackFrame = class(TFrame)
    pnlDrawBackFrame: TPanel;
    btnDrawback: TBitBtnLocked;
    procedure btnDrawbackClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objVenda: TFatVenda;
    onConfirm: procedure of object;

    procedure OnFormShow;
    procedure OnFormCreate;
    procedure OnFormDestroy;
  end;

implementation

uses
  untFuncoesSimples, untDigDrawbackItens;

{$R *.dfm}

{ TfraNumeroDrawbackFrame }

procedure TfraNumeroDrawbackFrame.btnDrawbackClick(Sender: TObject);
var
  frmDigDrawbackItens: TfrmDigDrawbackItens;
  intIdx: Integer;
  prcScroll: TprcScroll;
begin
  pCriarFormularios(TfrmDigDrawbackItens, frmDigDrawbackItens);
  pDisableControls(cdsVenda, prcScroll);
  try
    frmDigDrawbackItens.objVenda := objVenda;
    frmDigDrawbackItens.cdsProdutos.DisableControls;
    for intIdx := 0 to Length(objVenda.arrMatItens) - 1 do
    begin
      frmDigDrawbackItens.cdsProdutos.Append;
      frmDigDrawbackItens.cdsProdutosINDICE.AsInteger := intIdx;
      frmDigDrawbackItens.cdsProdutosCLAFIS.AsString  := objVenda.arrMatItens[intIdx].strClaFis;
      frmDigDrawbackItens.cdsProdutosCODITE.AsString  := objVenda.arrMatItens[intIdx].strCodIte;
      frmDigDrawbackItens.cdsProdutosDESITE.AsString  := objVenda.arrMatItens[intIdx].strDesIte;
      frmDigDrawbackItens.cdsProdutosCODUNI.AsString  := objVenda.arrMatItens[intIdx].strCodUni;
      frmDigDrawbackItens.cdsProdutosQTDITE.AsFloat   := objVenda.arrMatItens[intIdx].fltQtdIte;
      frmDigDrawbackItens.cdsProdutosVLRUNI.AsFloat   := objVenda.arrMatItens[intIdx].fltUniTar;
      frmDigDrawbackItens.cdsProdutosVLRTOT.AsFloat   := objVenda.arrMatItens[intIdx].fltTotIte;
      frmDigDrawbackItens.cdsProdutosCODSIT.AsString  := objVenda.arrMatItens[intIdx].strCodSit;
      frmDigDrawbackItens.cdsProdutosNUMDRW.AsString  := IIF((not fEmptyStr(objVenda.arrMatItens[intIdx]. strNumDrw)),
          objVenda.arrMatItens[intIdx].strNumDrw, objVenda.strNumeroDrawback);
      frmDigDrawbackItens.cdsProdutosAUTINC.AsInteger := objVenda.arrMatItens[intIdx].intAutInc;
      frmDigDrawbackItens.cdsProdutos.Post;
    end;
    frmDigDrawbackItens.cdsProdutos.First;
    frmDigDrawbackItens.cdsProdutos.EnableControls;

    if frmDigDrawbackItens.ShowModal = mrOK then
    begin
      objVenda.blnInformouDrawback := True;
      frmDigDrawbackItens.cdsProdutos.DisableControls;
      frmDigDrawbackItens.cdsProdutos.First;
      while not frmDigDrawbackItens.cdsProdutos.Eof do
      begin
        intIdx := frmDigDrawbackItens.cdsProdutosINDICE.AsInteger;

        objVenda.arrMatItens[intIdx].strClaFis := frmDigDrawbackItens.cdsProdutosCLAFIS.AsString;
        objVenda.arrMatItens[intIdx].strNumDrw := frmDigDrawbackItens.cdsProdutosNUMDRW.AsString;
        objVenda.arrMatItens[intIdx].strCstIpi := frmDigDrawbackItens.cdsProdutosCSTIPI.AsString;
        objVenda.arrMatItens[frmDigDrawbackItens.cdsProdutosINDICE.AsInteger].strEnqIpi := frmDigDrawbackItens.cdsProdutosENQIPI.AsString;

        If cdsVenda.Locate('AUTOINCREM', objVenda.arrMatItens[frmDigDrawbackItens.cdsProdutosINDICE.AsInteger].intAutInc, []) Then
        Begin
          cdsVenda.Edit;
          cdsVenda.FieldByName('ITE_NUMDRW').AsString := objVenda.arrMatItens[intIdx].strNumDrw;
          cdsVenda.Post;
        End;

        frmDigDrawbackItens.cdsProdutos.Next;
      end;

      if Assigned(onConfirm) then
        onConfirm();
    end;
  finally
    pEnableControls(cdsVenda, prcScroll);
    pFreeAndNil(frmDigDrawbackItens);
  end;
end;

procedure TfraNumeroDrawbackFrame.OnFormCreate;
begin
  inherited;
  onConfirm := Nil;
end;

procedure TfraNumeroDrawbackFrame.OnFormDestroy;
begin
  inherited;
end;

procedure TfraNumeroDrawbackFrame.OnFormShow;
begin
  if (objVenda.strCliEst = 'EX') then
    Self.Visible := True
  else
    Self.Visible := False;
end;

end.
