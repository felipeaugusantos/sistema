unit untSelPosCCD;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, Data.DB, cxDBData, Vcl.Menus, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls,
  cxGridLevel, cxClasses, cxGridCustomView, cxGrid, StrUtils, cxCheckBox,
  cxEditRepositoryItems, UniClientDataSet, cxExtEditRepositoryItems,
  cxContainer, cxTextEdit, cxMemo, Vcl.ImgList, cxCheckListBox, cxSplitter;

type
  TfrmSelPosCCD = class(TForm)
    pnlBotoes: TPanel;
    btnSelecionar: TcxButton;
    cxCupom: TcxMemo;
    pnlGrupo: TCategoryPanelGroup;
    imgList: TImageList;
    pnlCCD: TCategoryPanel;
    pnlNSU: TCategoryPanel;
    lstCCD: TcxCheckListBox;
    lstNSU: TcxCheckListBox;
    cxSplit: TcxSplitter;
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure pnlCCDExpand(Sender: TObject);
    procedure pnlNSUExpand(Sender: TObject);
    procedure lstCCDClickCheck(Sender: TObject; AIndex: Integer; APrevState,
      ANewState: TcxCheckBoxState);
    procedure lstNSUClickCheck(Sender: TObject; AIndex: Integer; APrevState,
      ANewState: TcxCheckBoxState);
    procedure FormShow(Sender: TObject);
  private
    lstValCCD: TStringList;
    lstValNSU: TStringList;

    function fVerificaSelecionado(blnCcd: Boolean = True): Boolean;
    function fValidaSelecoes: Boolean;
    { Private declarations }
  public
    { Public declarations }

    lstDados: TStringList;

    strPosCCD: String;
    strPosNSU: String;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmSelPosCCD.btnSelecionarClick(Sender: TObject);
begin

  Close;
  ModalResult := mrOk;

end;

function TfrmSelPosCCD.fValidaSelecoes: Boolean;
  Var
    intIdx: Integer;
Begin

  For intIdx := 0 To lstCCD.Count -1 Do
  Begin

    If lstCCD.Items[intIdx].Checked Then
    Begin
      strPosCCD := lstValCCD[intIdx];
      Break;
    End;

  End;

  For intIdx := 0 To lstNSU.Count -1 Do
  Begin

    If lstNSU.Items[intIdx].Checked Then
    Begin
      strPosNSU := lstValNSU[intIdx];
      Break;
    End;

  End;

  Result := True;
  If fEmptyStr(strPosCCD) Then
  Begin
    pMensagemOk('Deve ser selecionado uma opção informando a posição do Número de Autorização');
    pnlCCD.Expand;
    pSetFocus(lstCCD);
    Result := False;
  End
  Else If fEmptyStr(strPosNSU) Then
  Begin
    pMensagemOk('Deve ser selecionado uma opção informando a posição do NSU');
    pnlNSU.Expand;
    pSetFocus(lstNSU);
    Result := False;
  End;

End;

procedure TfrmSelPosCCD.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  
  If Not fValidaSelecoes Then
  Begin
    ModalResult := mrCancel;
    Action := caNone;
  End
  Else
  Begin
    FreeAndNil(lstValCCD);
    FreeAndNil(lstValNSU);
  End;

end;

procedure TfrmSelPosCCD.FormCreate(Sender: TObject);
begin
  lstValCCD := TStringList.Create;
  lstValNSU := TStringList.Create;

  strPosCCD := '';
  strPosNSU := '';
end;

procedure TfrmSelPosCCD.FormShow(Sender: TObject);
  Var
    intCont: Integer;
begin

  For intCont := 0 To lstDados.Count -1 Do
  Begin

    If Pos('"', lstDados[intCont]) > 0 Then
    Begin
      cxCupom.Lines.Add(Copy(lstDados[intCont], Pos('"', lstDados[intCont]), Length(lstDados[intCont])));
    End

    Else If Length(Trim(Copy(lstDados[intCont], 9, Length(lstDados[intCont])))) > 3 Then
    Begin

      With lstCCD.Items.Add Do Caption := Trim(Copy(lstDados[intCont], 9, Length(lstDados[intCont])));
      With lstNSU.Items.Add Do Caption := Trim(Copy(lstDados[intCont], 9, Length(lstDados[intCont])));

      lstValCCD.Add(LeftStr(lstDados[intCont],3));
      lstValNSU.Add(LeftStr(lstDados[intCont],3));

    End;

  End;

end;

procedure TfrmSelPosCCD.pnlCCDExpand(Sender: TObject);
begin

  If Not pnlNSU.Collapsed Then
    pnlNSU.Collapse;
end;

procedure TfrmSelPosCCD.pnlNSUExpand(Sender: TObject);
begin

  If Not pnlCCD.Collapsed Then
    pnlCCD.Collapse;

end;

function TfrmSelPosCCD.fVerificaSelecionado(blnCcd: Boolean = True): Boolean;

  function fRetQtdSel(lst: TcxCheckListBox): Integer;
    Var
      intCont: Integer;
  Begin

    Result := 0;
    For intCont := 0 To lst.Items.Count -1 Do
    Begin
      If lst.Items[intCont].Checked Then
        Inc(Result);
    End;

  End;

Begin
  Result := False;

  If blnCcd And (fRetQtdSel(lstCCD) > 1) Then Result := True
  Else If (Not blnCcd) And (fRetQtdSel(lstNSU) > 1) Then Result := True;

End;

procedure TfrmSelPosCCD.lstCCDClickCheck(Sender: TObject; AIndex: Integer;
  APrevState, ANewState: TcxCheckBoxState);
begin

  If (ANewState = cbsChecked) Then
  Begin

    If fVerificaSelecionado Then
      lstCCD.Items[AIndex].Checked := False
    Else
    Begin
      pnlCCD.CollapsedImageIndex := 0;
      pnlCCD.ExpandedImageIndex  := 0;
      pnlNSU.Expand;
    End;

  End
  Else
  Begin
    pnlCCD.CollapsedImageIndex := -1;
    pnlCCD.ExpandedImageIndex  := -1;
  End;

end;

procedure TfrmSelPosCCD.lstNSUClickCheck(Sender: TObject; AIndex: Integer;
  APrevState, ANewState: TcxCheckBoxState);
begin

  If (ANewState = cbsChecked) Then
  Begin

    If fVerificaSelecionado(False) Then
      lstNSU.Items[AIndex].Checked := False
    Else
    Begin
      pnlNSU.CollapsedImageIndex := 0;
      pnlNSU.ExpandedImageIndex  := 0;

    End;

  End
  Else
  Begin
    pnlNSU.CollapsedImageIndex := -1;
    pnlNSU.ExpandedImageIndex  := -1;
  End;

end;

end.
