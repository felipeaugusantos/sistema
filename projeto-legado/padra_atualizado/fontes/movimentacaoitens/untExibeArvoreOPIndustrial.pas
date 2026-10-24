unit untExibeArvoreOPIndustrial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, untPai, AppEvnts, Menus, Uni,
  StdCtrls, Buttons, BitBtnLockedIncrem, ExtCtrls, ComCtrls,
  ImgList, dxScreenTip, cxClasses, dxCustomHint, cxHint, frxClass,
  frxExportCSVTestabilidade, System.ImageList;

type
  TRecOrdOpe = record
    strAutoIn : String;
    strCodPro : String;
    strDtaPro : String;
    strCodIte : string;
    fltQtdApr : Double;
    fltQtdUsa : Double;
    fltUsaEst : Double;
    fltQtdSub : Double;
    dtaDtaBai : TDate;
    blnImprim : Boolean;
  end;

  TPRecOrdOpe = ^TRecOrdOpe;

  TfrmExibeArvoreOP = class(TfrmPai)
    tvArvore: TTreeView;
    imgLista: TImageList;
    btnMarcar: TBitBtnLocked;
    btnDesMarcar: TBitBtnLocked;
    pnlOrdem: TPanel;
    Label1: TLabel;
    rdgOrdem: TRadioGroup;
    pnlLegenda: TPanel;
    Shape1: TShape;
    Shape2: TShape;
    Label2: TLabel;
    Label3: TLabel;
    cxHint: TcxHintStyleController;
    procedure tvArvoreCustomDrawItem(Sender: TCustomTreeView; Node: TTreeNode;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure tvArvoreDblClick(Sender: TObject);
    procedure btnMarcarClick(Sender: TObject);
    procedure tvArvoreKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure tvArvoreMouseLeave(Sender: TObject);
    procedure tvArvoreClick(Sender: TObject);
  private
    FCodPro : String;
    FDtaPro : TDateTime;

    procedure pMontaArvore;
    procedure pAddFilhos(strAutoincrem : string; noNodePai : TTreeNode);
    function fRetDescricaoNo(objRecOrdOpe : TRecOrdOpe) : String;
    procedure pSetImage(Node : TTreeNode);
    function fSetResult : TStringList;
  public
    Class Procedure pExibeArvore(strCodPro : String; dtaDtaPro : TDateTime);
    Class Function fSelectOpImpressao(strCodPro : String; dtaDtaPro : TDateTime): TStringList;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmExibeArvoreOP }

class procedure TfrmExibeArvoreOP.pExibeArvore(strCodPro: String; dtaDtaPro : TDateTime);
var
  frmExibeArvoreOP: TfrmExibeArvoreOP;
begin
  pCriarFormularios(TfrmExibeArvoreOP, frmExibeArvoreOP);
  with frmExibeArvoreOP do
  Begin
    FCodPro := strCodPro;
    FDtaPro := dtaDtaPro;
    pMontaArvore;

    btnMarcar.Visible    := False;
    btnDesMarcar.Visible := False;
    tvArvore.Images      := nil;
    tvArvore.DragMode    := dmManual;

    ShowModal;
  End;
  FreeAndNil(frmExibeArvoreOP);

end;

procedure TfrmExibeArvoreOP.pMontaArvore;
  Var
    qrytabela : TUniQuery;
    noFirtNode: TTreeNode;
    objInf : TPRecOrdOpe;
    intContador : Integer;
begin
  noFirtNode := nil;
  try
    For intContador := 0 to tvArvore.Items.Count -1 do
    Begin
      Dispose(tvArvore.Items[intContador].Data);
    End;
    tvArvore.Items.Clear;

    qrytabela := fCriaQuery(Self);
    With qrytabela, Sql Do
    Begin
      Add(' SELECT AUTOINCREM,         ');
      Add('        ORD_CODEMP,         ');
      Add('        ORD_CODORD,         ');
      Add('        (SELECT SUM(ORD_QTDPRO) FROM ORDDET WHERE ORD_SEQGER = ORDGER.AUTOINCREM ) AS ORD_QTDPRO, ' );
      Add('        ORD_DTACAD,         ');
      Add('        ORD_CODITE,         ');
      Add('        ORD_DTABAI          ');
      Add(' FROM ORDGER                ');
      Add(' WHERE ORD_CODORD = :CODORD ');
      Add('   AND ORD_DTACAD = :DTACAD ');
      Add('   AND ORD_CODEMP = :CODEMP ');

      ParamByName('CODORD').AsString := FCodPro;
      ParamByName('DTACAD').AsDateTime:= FDtaPro;
      ParamByName('CODEMP').AsString := VS_strCodEmp;

      Open;

      objInf := New(TPRecOrdOpe);
      objInf^.strAutoIn := FieldByName('AUTOINCREM').AsString;
      objInf^.strCodPro := FieldByName('ORD_CODORD').AsString;
      objInf^.strDtaPro := FormatDateTime('dd/mm/yyyy', FieldByName('ORD_DTACAD').AsDateTime );
      objInf^.strCodIte := FieldByName('ORD_CODITE').AsString;
      objInf^.fltQtdApr := FieldByName('ORD_QTDPRO').AsFloat;
      objInf^.fltUsaEst := 0;
      objInf^.fltQtdSub := 0;
      objInf^.fltQtdUsa := FieldByName('ORD_QTDPRO').AsFloat;
      objInf^.dtaDtaBai := FieldByName('ORD_DTABAI').AsDateTime;
      objInf^.blnImprim := FieldByName('ORD_DTABAI').IsNull;

      if (not objInf^.blnImprim) And ( not fCfgSis('TAVOPI', varBoolean)) Then  { 'TAVOPI' = 'N', Não irá mostrar a arvore, precisa marcar todas as OP para imprimir}
        objInf^.blnImprim := True;

      noFirtNode := tvArvore.Items.AddObject(noFirtNode, fRetDescricaoNo(TRecOrdOpe(objInf^)), objInf );
      pSetImage(noFirtNode);
      pAddFilhos(FieldByName('AUTOINCREM').AsString, noFirtNode);

      tvArvore.FullExpand;

    End;

  Finally
    FreeAndNil(qrytabela);
  end;

end;

procedure TfrmExibeArvoreOP.pSetImage(Node: TTreeNode);
begin
  Node.ImageIndex    := IIF(TRecOrdOpe(Node.Data^).blnImprim, 1, 0);
  Node.SelectedIndex := IIF(TRecOrdOpe(Node.Data^).blnImprim, 1, 0);
end;

procedure TfrmExibeArvoreOP.tvArvoreClick(Sender: TObject);
  var
    strHint   : String;
    poPoint   : TPoint;
    noNode    : TTreeNode;
    intContador : Integer;

  procedure pAddOrdem(Node  : TTreeNode);
  Begin
    if Node.Parent <> Nil then
      strHint := strHint + fPadR('- QUANTIDADES PARA PRODUZIR ' +
                                 TRecOrdOpe(Node.Parent.Data^).strCodPro + ' - ' +
                                 TRecOrdOpe(Node.Parent.Data^).strCodIte + ' - ' +
                                 fRetNomProduto(TRecOrdOpe(Node.Parent.Data^).strCodIte), 65) + #13#10;

    with Node, TRecOrdOpe(Node.Data^) do
    Begin
      strHint := strHint + fPadR('    QUANTIDADE NECESSÁRIA: ',50) + fPadL(FormatFloat('#,##0.00', fltQtdUsa),15) + #13#10;
      strHint := strHint + fPadR('    QUANTIDADE CONSIDERADA DO ESTOQUE: ',50) + fPadL(FormatFloat('#,##0.00', fltUsaEst),15) + #13#10;
      strHint := strHint + fPadR('    QUANTIDADE A PRODUZIR: ',50) + fPadL(FormatFloat('#,##0.00', fltQtdSub),15) + #13#10;
      strHint := strHint + fPadR('', 65, '-') + #13#10;
    End;
  End;

begin
  inherited;
  poPoint := Mouse.CursorPos;
  poPoint := tvArvore.ScreenToClient(poPoint);

  noNode := tvArvore.GetNodeAt(poPoint.X, poPoint.Y);
  if noNode <> Nil then
  begin
    with noNode, TRecOrdOpe(noNode.Data^) do
    Begin
      strHint := '';
      strHint := strHint + 'ORDEM DE PRODUÇÃO: ' + strCodPro + #13#10;
      strHint := strHint + 'PRODUÇÃO: ' + strCodIte + ' - ' + fRetNomProduto(strCodIte) + #13#10;
      strHint := strHint + fPadR('', 65, '-') + #13#10;

      For intContador := 0 To tvArvore.Items.Count -1 Do
        if strCodPro = TRecOrdOpe(tvArvore.Items[intContador].Data^).strCodPro then
          pAddOrdem(tvArvore.Items[intContador]);

      strHint := strHint + fPadR('SALDO TOTAL A PRODUZIR: ', 50) + fPadL(FormatFloat('#,##0.00', fltQtdApr),15);

    End;

    cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3, '', strHint);
  end
  Else
    cxHint.HideHint;

end;

procedure TfrmExibeArvoreOP.tvArvoreCustomDrawItem(Sender: TCustomTreeView;
  Node: TTreeNode; State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  inherited;
  if Sender.Selected = Node then
    Sender.Canvas.Brush.Color := clInfoBk;

  if TRecOrdOpe(Node.Data^).dtaDtaBai = 0 then
    Sender.Canvas.Font.Color := clRed
  Else
    Sender.Canvas.Font.Color := clBlack;
end;

procedure TfrmExibeArvoreOP.tvArvoreDblClick(Sender: TObject);
  Var
    poPoint   : TPoint;
begin
  inherited;
  poPoint := Mouse.CursorPos;
  poPoint := tvArvore.ScreenToClient(poPoint);

  If tvArvore.GetNodeAt(poPoint.X, poPoint.Y) <> Nil  Then
  Begin
    TRecOrdOpe(tvArvore.Selected.Data^).blnImprim := not TRecOrdOpe(tvArvore.Selected.Data^).blnImprim;
    pSetImage(tvArvore.Selected);
    tvArvore.FullExpand;
  End;
end;

procedure TfrmExibeArvoreOP.tvArvoreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    tvArvoreDblClick(Nil);
end;

procedure TfrmExibeArvoreOP.tvArvoreMouseLeave(Sender: TObject);
begin
  inherited;
  cxHint.HideHint;
end;

procedure TfrmExibeArvoreOP.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnSair);
end;

procedure TfrmExibeArvoreOP.btnMarcarClick(Sender: TObject);
  Var
    noAtual : TTreeNode;
begin
  inherited;
  noAtual := tvArvore.Items.GetFirstNode;
  TRecOrdOpe(noAtual.Data^).blnImprim := (TBitBtnLocked(Sender).Tag = 1);
  pSetImage(noAtual);
  while noAtual <> Nil do
  Begin
    TRecOrdOpe(noAtual.Data^).blnImprim := (TBitBtnLocked(Sender).Tag = 1);
    pSetImage(noAtual);
    noAtual := noAtual.GetNext;
  End;
  tvArvore.Repaint;

end;

function TfrmExibeArvoreOP.fRetDescricaoNo(objRecOrdOpe: TRecOrdOpe): String;
begin
  With objRecOrdOpe Do
    Result := strCodPro + ' ' +
              strCodIte + ' - ' +
              fRetNomProduto(strCodIte) + ' - ' +
              FormatFloat('#,##0.00', fltQtdUsa) + ' + ' + FormatFloat('#,##0.00', fltUsaEst) + ' (Estoque)' +' / '+ FormatFloat('#,##0.00', fltQtdApr);
end;

class function TfrmExibeArvoreOP.fSelectOpImpressao(
  strCodPro: String; dtaDtaPro : TDateTime): TStringList;
var
  frmExibeArvoreOP: TfrmExibeArvoreOP;
begin
  pCriarFormularios(TfrmExibeArvoreOP, frmExibeArvoreOP);
  with frmExibeArvoreOP do
  Begin
    FCodPro := strCodPro;
    FDtaPro := dtaDtaPro;
    pMontaArvore;

    btnSair.Glyph.FreeImage;
    btnSair.Caption     := '&Confirmar';
    btnSair.ModalResult := mrOk;
    btnSair.OnClick     := nil;
    tvArvore.Images     := imgLista;
    tvArvore.DragMode   := dmAutomatic;
    pnlOrdem.Visible    := True;

    If fCfgSis('TAVOPI', varBoolean) Then
    Begin
      if ShowModal = mrOk Then
        Result := fSetResult
      Else
        Result := Nil;
    End
    Else
      Result := fSetResult;

  End;
  FreeAndNil(frmExibeArvoreOP);

end;

function TfrmExibeArvoreOP.fSetResult: TStringList;
  Var
    nodeTmp : TTreeNode;
    stlResult : TStringList;
begin
  stlResult := TStringList.Create;
  Try
    nodeTmp := tvArvore.Items.GetFirstNode;

    While (nodeTmp <> Nil) do
    Begin
      if TRecOrdOpe(nodeTmp.Data^).blnImprim then
        case rdgOrdem.ItemIndex of
          0 : stlResult.Insert(0, TRecOrdOpe(nodeTmp.Data^).strAutoIn );
          1 : stlResult.Add(TRecOrdOpe(nodeTmp.Data^).strAutoIn );
        end;

      nodeTmp := nodeTmp.GetNext;
    End;
  Finally
    Result := stlResult;
  End;


end;

procedure TfrmExibeArvoreOP.pAddFilhos(strAutoincrem: string;
  noNodePai: TTreeNode);
  Var
    qrytabela : TUniQuery;
    noGerado  : TTreeNode;
    objInf : TPRecOrdOpe;
begin
  try
    qrytabela := fCriaQuery(Self);
    With qrytabela, Sql Do
    Begin
      Add(' SELECT ORD_CODEMP,                         ');
      Add('        ORD_CODORD,                         ');
      Add('        ORD_DTACAD,                         ');
      Add('        ORD_CODITE,                         ');
      Add(' (SELECT SUM(ORD_QTDPRO) FROM ORDDET WHERE ORD_SEQGER = ORDGER.AUTOINCREM ) AS ORD_QTDPRO, ');
      Add('        ORD_QTDUSA,                         ');
      Add('        ORD_USAEST,                         ');
      Add('        ORD_QTDSUB,                         ');
      Add('        ORD_DTABAI,                         ');
      Add('        ORDGER.AUTOINCREM                   ');
      Add(' FROM ORDORI                                ');
      Add('   LEFT JOIN ORDGER                         ');
      Add('   ON ORDGER.AUTOINCREM = ORDORI.ORD_SEQUSA ');
      Add(' WHERE ORD_SEQGER = :AUTOINC                ');

      ParamByName('AUTOINC').AsString := strAutoincrem;

      Open;

      While Not Eof do
      Begin
        objInf := New(TPRecOrdOpe);
        objInf^.strAutoIn := FieldByName('AUTOINCREM').AsString;        
        objInf^.strCodPro := FieldByName('ORD_CODORD').AsString;
        objInf^.strDtaPro := FormatDateTime('dd/mm/yyyy', FieldByName('ORD_DTACAD').AsDateTime);
        objInf^.strCodIte := FieldByName('ORD_CODITE').AsString;
        objInf^.fltQtdApr := FieldByName('ORD_QTDPRO').AsFloat;
        objInf^.fltQtdUsa := FieldByName('ORD_QTDUSA').AsFloat;
        objInf^.fltUsaEst := FieldByName('ORD_USAEST').AsFloat;
        objInf^.fltQtdSub := FieldByName('ORD_QTDSUB').AsFloat;
        objInf^.dtaDtaBai := FieldByName('ORD_DTABAI').AsDateTime;
        objInf^.blnImprim := FieldByName('ORD_DTABAI').IsNull;

        noGerado := tvArvore.Items.AddChildObject(noNodePai, fRetDescricaoNo(TRecOrdOpe(objInf^)), objInf);
        pSetImage(noGerado);
        pAddFilhos(FieldByName('AUTOINCREM').AsString, noGerado);

        Next;
      End;

    End;

  Finally
    FreeAndNil(qrytabela);
  end;
end;

end.
