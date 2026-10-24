unit untExibeArvoreOrdProd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.AppEvnts, Vcl.Menus,
  Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, Uni,
  Vcl.ImgList, dxScreenTip, cxClasses, dxCustomHint, cxHint, System.ImageList,
  frxClass, frxExportCSVTestabilidade;

type
  TRecOrdOpe = record
    strCodPro : String;
    strCodIte : string;
    fltQtdApr : Double;
    fltQtdUsa : Double;
    fltUsaEst : Double;
    fltQtdSub : Double;
    dtaDtaBai : TDate;
    blnImprim : Boolean;
  end;

  TPRecOrdOpe = ^TRecOrdOpe;

  TfrmExibeArvoreOrdProd = class(TfrmPai)
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

    procedure pMontaArvore(blnImpressao : boolean = false);
    procedure pAddFilhos(strAutoincrem : string; noNodePai : TTreeNode; blnImpressao : boolean = false);
    procedure pAddMateriaPrima(Node: TTreeNode; strCodPro: String; Var strHintMateriaPrima: String);
    function fRetDescricaoNo(objRecOrdOpe : TRecOrdOpe) : String;
    procedure pSetImage(Node : TTreeNode);
    function fSetResult : TStringList;
  public
    Class Procedure pExibeArvore(strCodPro : String);
    Class Function fSelectOpImpressao(strCodPro : String): TStringList;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmExibeArvoreOrdProd }

class procedure TfrmExibeArvoreOrdProd.pExibeArvore(strCodPro: String);
var
  frmExibeArvoreOrdProd: TfrmExibeArvoreOrdProd;
begin
  pCriarFormularios(TfrmExibeArvoreOrdProd, frmExibeArvoreOrdProd);
  with frmExibeArvoreOrdProd do
  Begin
    FCodPro := strCodPro;
    pMontaArvore;

    btnMarcar.Visible    := False;
    btnDesMarcar.Visible := False;
    tvArvore.Images      := nil;
    tvArvore.DragMode    := dmManual;

    ShowModal;
  End;
  FreeAndNil(frmExibeArvoreOrdProd);

end;

procedure TfrmExibeArvoreOrdProd.pMontaArvore(blnImpressao : boolean = false);
  Var
    qrytabela : TUniQuery;
    noFirtNode: TTreeNode;
    objInf : TPRecOrdOpe;
    intContador : Integer;
begin
  try
    For intContador := 0 to tvArvore.Items.Count -1 do
    Begin
      Dispose(tvArvore.Items[intContador].Data);
    End;
    tvArvore.Items.Clear;


    qrytabela := fCriaQuery(Self);
    With qrytabela, Sql Do
    Begin
      Add(' SELECT AUTOINCREM,   ');
      Add('        PRO_CODEMP,   ');
      Add('        PRO_CODPRO,   ');
      Add('        PRO_CODITE,   ');
      Add('        PRO_QTDAPR,   ');
      Add('        PRO_DTABAI    ');
      Add(' FROM MOVPRO          ');
      Add(' WHERE                ');
      Add(' PRO_CODPRO = :CODPRO ');

      ParamByName('CODPRO').AsString := FCodPro;

      Open;

      objInf := New(TPRecOrdOpe);
      objInf^.strCodPro := FieldByName('PRO_CODPRO').AsString;
      objInf^.strCodIte := FieldByName('PRO_CODITE').AsString;
      objInf^.fltQtdApr := FieldByName('PRO_QTDAPR').AsFloat;
      objInf^.fltUsaEst := 0;
      objInf^.fltQtdSub := 0;
      objInf^.fltQtdUsa := FieldByName('PRO_QTDAPR').AsFloat;
      objInf^.dtaDtaBai := FieldByName('PRO_DTABAI').AsDateTime;
      objInf^.blnImprim := FieldByName('PRO_DTABAI').IsNull;

      noFirtNode := nil;
      noFirtNode := tvArvore.Items.AddObject(noFirtNode, fRetDescricaoNo(TRecOrdOpe(objInf^)), objInf );
      pSetImage(noFirtNode);
      pAddFilhos(FieldByName('AUTOINCREM').AsString, noFirtNode, blnImpressao);

      tvArvore.FullExpand;

    End;

  Finally
    FreeAndNil(qrytabela);
  end;

end;

procedure TfrmExibeArvoreOrdProd.pSetImage(Node: TTreeNode);
begin
  Node.ImageIndex    := IIF(TRecOrdOpe(Node.Data^).blnImprim, 1, 0);
  Node.SelectedIndex := IIF(TRecOrdOpe(Node.Data^).blnImprim, 1, 0);
end;

procedure TfrmExibeArvoreOrdProd.pAddMateriaPrima(Node  : TTreeNode; strCodPro: String; Var strHintMateriaPrima: String);
Const
  SQL_MATERIA_PRIMA = ' SELECT                     '+
                      '        I.ITE_CODITE,       '+
                      '        ITE_DESITE,         '+
                      '        ITE_CODFAB,         '+
                      '        ITE_REFERE,         '+
                      '        UNI_SIGUNI,         '+
                      '        DOP_QTDITE          '+
                      ' FROM MOVPRO P              '+
                      '   INNER JOIN DETPRO D ON (D.DOP_SEQGER = P.AUTOINCREM) '+
                      '   INNER JOIN CADITE C ON C.ITE_CODITE = DOP_ITESUB     '+
                      '   INNER JOIN ITEGER I ON I.ITE_CODITE = C.ITE_CODITE   '+
                      '                      AND I.ITE_CODEMP = :CODEMP        '+
                      '   INNER JOIN CADUNI   ON UNI_CODUNI = C.ITE_CODUNI     '+
                      ' WHERE PRO_CODPRO = :CODPRO  AND '+
                      '    P.PRO_CODEMP  = :CODEMP  AND '+
                      '    D.DOP_CODEMP  = :CODEMP      ';

var
  qryConsulta : TUniQuery;
Begin
  Try
    qryConsulta:= fCriaQuery;
    qryConsulta.SQL.Add(SQL_MATERIA_PRIMA);
    qryConsulta.ParamByName('CODPRO').AsString:= strCodPro;
    qryConsulta.ParamByName('CODEMP').AsString:= VS_strCodEmp;
    qryConsulta.Open;

    with Node, TRecOrdOpe(Node.Data^) do
    Begin
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' CODIGO', 7);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' DESCRIÇÃO',25);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' COD FABRICA',15);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' REFERENCIA',15);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' UNI',3);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' QTD',5) + #13#10;
    End;

    qryConsulta.First;
    While Not qryConsulta.Eof do
    Begin

      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('ITE_CODITE').AsString, 7);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('ITE_DESITE').AsString, 25);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('ITE_CODFAB').AsString, 15);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('ITE_REFERE').AsString, 15);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('UNI_SIGUNI').AsString, 3);
      strHintMateriaPrima := strHintMateriaPrima + fPadR(' '+qryConsulta.FieldByName('DOP_QTDITE').AsString, 5) + #13#10;

      qryConsulta.Next;
    End;

    strHintMateriaPrima := strHintMateriaPrima + fPadR('', 73, '-') + #13#10;

  Finally
    FreeAndNil(qryConsulta);
  End;
End;

procedure TfrmExibeArvoreOrdProd.tvArvoreClick(Sender: TObject);
  var
    strHint   : String;
    poPoint   : TPoint;
    noNode    : TTreeNode;
    intContador : Integer;
    strHintMateriaPrima : String;

  procedure pAddOrdem(Node  : TTreeNode);
  Begin
    if Node.Parent <> Nil then
      strHint := strHint + fPadR('- QUANTIDADES PARA PRODUZIR ' +
                                 TRecOrdOpe(Node.Parent.Data^).strCodPro + ' - ' +
                                 TRecOrdOpe(Node.Parent.Data^).strCodIte + ' - ' +
                                 fRetNomProduto(TRecOrdOpe(Node.Parent.Data^).strCodIte), 73) + #13#10;

    with Node, TRecOrdOpe(Node.Data^) do
    Begin
      strHint := strHint + fPadR(' QUANTIDADE NECESSÁRIA: ',50) + fPadL(FormatFloat('#,##0.00', fltQtdSub),15) + #13#10;
      strHint := strHint + fPadR(' QUANTIDADE CONSIDERADA DO ESTOQUE: ',50) + fPadL(FormatFloat('#,##0.00', fltUsaEst),15) + #13#10;
      strHint := strHint + fPadR(' QUANTIDADE A PRODUZIR: ',50) + fPadL(FormatFloat('#,##0.00', fltQtdUsa),15) + #13#10;
      strHint := strHint + fPadR('', 73, '-') + #13#10;
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
      strHint := strHint + fPadR('', 73, '-') + #13#10;

      For intContador := 0 To tvArvore.Items.Count -1 Do
      Begin
        if strCodPro = TRecOrdOpe(tvArvore.Items[intContador].Data^).strCodPro then
        Begin
          pAddOrdem(tvArvore.Items[intContador]);
          pAddMateriaPrima(tvArvore.Items[intContador], strCodPro, strHintMateriaPrima);
          strHint:= strHint + #13#10 +
                    strHintMateriaPrima;
        End;
      End;

      strHint := strHint + fPadR('SALDO TOTAL A PRODUZIR: ', 50) + fPadL(FormatFloat('#,##0.00', fltQtdApr),15);

    End;

    cxHint.ShowHint(Mouse.CursorPos.X + 3, Mouse.CursorPos.Y + 3, '', strHint);
  end
  Else
    cxHint.HideHint;

end;

procedure TfrmExibeArvoreOrdProd.tvArvoreCustomDrawItem(Sender: TCustomTreeView;
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

procedure TfrmExibeArvoreOrdProd.tvArvoreDblClick(Sender: TObject);
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

procedure TfrmExibeArvoreOrdProd.tvArvoreKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_RETURN then
    tvArvoreDblClick(Nil);
end;

procedure TfrmExibeArvoreOrdProd.tvArvoreMouseLeave(Sender: TObject);
begin
  inherited;
  cxHint.HideHint;
end;

procedure TfrmExibeArvoreOrdProd.FormShow(Sender: TObject);
begin
  inherited;
  pSetFocus(btnMarcar);
end;

procedure TfrmExibeArvoreOrdProd.btnMarcarClick(Sender: TObject);
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

end;

function TfrmExibeArvoreOrdProd.fRetDescricaoNo(objRecOrdOpe: TRecOrdOpe): String;
begin
  With objRecOrdOpe Do
    Result := strCodPro + ' ' +
              strCodIte + ' - ' +
              fRetNomProduto(strCodIte) + ' - ' +
              FormatFloat('#,##0.00', fltQtdUsa) + ' + ' + FormatFloat('#,##0.00', fltUsaEst) + ' (Estoque)' +' / '+ FormatFloat('#,##0.00', fltQtdApr);
end;

class function TfrmExibeArvoreOrdProd.fSelectOpImpressao(
  strCodPro: String): TStringList;
var
  frmExibeArvoreOrdProd: TfrmExibeArvoreOrdProd;
begin
  pCriarFormularios(TfrmExibeArvoreOrdProd, frmExibeArvoreOrdProd);
  with frmExibeArvoreOrdProd do
  Begin
    FCodPro := strCodPro;
    pMontaArvore(true);

    btnSair.Glyph.FreeImage;
    btnSair.Caption     := '&Confirmar';
    btnSair.ModalResult := mrOk;
    btnSair.OnClick     := nil;
    tvArvore.Images     := imgLista;
    tvArvore.DragMode   := dmAutomatic;
    pnlOrdem.Visible    := True;

    if ShowModal = mrOk Then
      Result := fSetResult
    Else
      Result := Nil;
  End;
  FreeAndNil(frmExibeArvoreOrdProd);

end;

function TfrmExibeArvoreOrdProd.fSetResult: TStringList;
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
          0 : stlResult.Insert(0, TRecOrdOpe(nodeTmp.Data^).strCodPro );
          1 : stlResult.Add(TRecOrdOpe(nodeTmp.Data^).strCodPro );
        end;

      nodeTmp := nodeTmp.GetNext;
    End;
  Finally
    Result := stlResult;
  End;


end;

procedure TfrmExibeArvoreOrdProd.pAddFilhos(strAutoincrem: string;
  noNodePai: TTreeNode; blnImpressao : boolean = false);
  Var
    qrytabela : TUniQuery;
    noGerado  : TTreeNode;
    objInf : TPRecOrdOpe;
    nodeTmp : TTreeNode;
    blnJaExiste : boolean;
begin
  try
    qrytabela := fCriaQuery(Self);
    With qrytabela, Sql Do
    Begin
      Add(' SELECT PRO_CODEMP,                         ');
      Add('        PRO_CODPRO,                         ');
      Add('        PRO_CODITE,                         ');
      Add('        PRO_QTDAPR,                         ');
      Add('        PRO_QTDUSA,                         ');
      Add('        PRO_USAEST,                         ');
      Add('        PRO_QTDSUB,                         ');
      Add('        PRO_DTABAI,                         ');
      Add('        MOVPRO.AUTOINCREM                   ');
      Add(' FROM ORIPRO                                ');
      Add('   LEFT JOIN MOVPRO                         ');
      Add('   ON MOVPRO.AUTOINCREM = ORIPRO.PRO_SEQGER ');
      Add(' WHERE PRO_SEQUSA = :AUTOINC                ');

      ParamByName('AUTOINC').AsString := strAutoincrem;

      Open;

      While Not Eof do
      Begin
        noGerado := nil;
        blnJaExiste := False;
        if blnImpressao then
        begin

          nodeTmp := tvArvore.Items.GetFirstNode;

          blnJaExiste := False;
          While (nodeTmp <> Nil) do
          Begin
            if TRecOrdOpe(nodeTmp.Data^).strCodPro = FieldByName('PRO_CODPRO').AsString then
              blnJaExiste := True;
            nodeTmp := nodeTmp.GetNext;
          End;

        end;

        if (not blnImpressao) or (not blnJaExiste) then
        begin
        objInf := New(TPRecOrdOpe);
        objInf^.strCodPro := FieldByName('PRO_CODPRO').AsString;
        objInf^.strCodIte := FieldByName('PRO_CODITE').AsString;
        objInf^.fltQtdApr := FieldByName('PRO_QTDAPR').AsFloat;
        objInf^.fltQtdUsa := FieldByName('PRO_QTDUSA').AsFloat;
        objInf^.fltUsaEst := FieldByName('PRO_USAEST').AsFloat;
        objInf^.fltQtdSub := FieldByName('PRO_QTDSUB').AsFloat;
        objInf^.dtaDtaBai := FieldByName('PRO_DTABAI').AsDateTime;
        objInf^.blnImprim := FieldByName('PRO_DTABAI').IsNull;

        if blnImpressao then
          noGerado := tvArvore.Items.AddObject(nil, fRetDescricaoNo(TRecOrdOpe(objInf^)), objInf )
        else
          noGerado := tvArvore.Items.AddChildObject(noNodePai, fRetDescricaoNo(TRecOrdOpe(objInf^)), objInf);
        pSetImage(noGerado);

        end;

        pAddFilhos(FieldByName('AUTOINCREM').AsString, noGerado, blnImpressao);

        Next;
      End;

    End;

  Finally
    FreeAndNil(qrytabela);
  end;
end;



end.
