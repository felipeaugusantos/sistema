unit untCalcGirFrame;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxContainer, cxEdit, Vcl.StdCtrls,
  ComboBoxFocus, Vcl.ExtCtrls, EditFocus, cxGroupBox, Data.DB, dxCore,
  Datasnap.DBClient, UniClientDataSet, untTEditFocusWithTConsultasArray;

type
  TfraCalcGirFrame = class(TFrame)
    gpbCalculoSugestao: TcxGroupBox;
    lblConsiderar: TLabel;
    lblDiasPrev: TLabel;
    chkMultCompra: TCheckBox;
    chkEstMin: TCheckBox;
    chkEstMax: TCheckBox;
    chkPedPen: TCheckBox;
    chkCotAbe: TCheckBox;
    chkTransf: TCheckBox;
    chkGarPen: TCheckBox;
    chkPedVen: TCheckBox;
    edtDiaPre: TEditFocus;
    chkOrdPro: TCheckBox;
    chkVenPer: TCheckBox;
    chkArredQtdeSugest: TCheckBox;
    grbPedMlj: TcxGroupBox;
    chkAgrEmp: TCheckBox;
    rdgSugInd: TRadioGroup;
    cbxAbrEmp: TComboBoxFocus;
    chkPonPed: TCheckBox;
    chkAteMax: TCheckBox;
    cdsEmpSel: TUniClientDataSet;
    cdsEmpSelCODEMP: TStringField;
    cdsEmpSelDESCRI: TStringField;
    cdsEmpSelMARDES: TStringField;
    cdsEmpSelEMPVIS: TStringField;
    chkAgrSim: TCheckBox;
    chkPedPenTransferencia: TCheckBox;
    chkEndere: TCheckBox;
    chkConsRequisicao: TCheckBox;
    cdsEmpSubtraiTansf: TUniClientDataSet;
    StringField1: TStringField;
    StringField2: TStringField;
    StringField3: TStringField;
    lblLinkEmpresas: TLabel;
    chkMultiploAposCentralizar: TCheckBox;
    rdgEntFut: TGroupBox;
    chkPrevisao: TCheckBox;
    chkFalta: TCheckBox;
    chkAguarda: TCheckBox;
    chkVenEsp: TCheckBox;
    Label1: TLabel;
    rdgTipCalVenPer: TRadioGroup;
    chkDecSalExt: TCheckBox;
    chkPedGar: TCheckBox;
    procedure chkAgrEmpClick(Sender: TObject);
    procedure chkAteMaxClick(Sender: TObject);
    procedure chkEstMaxClick(Sender: TObject);
    procedure chkEstMinClick(Sender: TObject);
    procedure chkPedVenClick(Sender: TObject);
    procedure chkPonPedClick(Sender: TObject);
    procedure cdsEmpSelBeforePost(DataSet: TDataSet);
    procedure chkPedPenClick(Sender: TObject);
    procedure chkPedPenTransferenciaClick(Sender: TObject);
    procedure lblLinkEmpresasClick(Sender: TObject);
    procedure chkMultCompraClick(Sender: TObject);

  private
    { Private declarations }
    blnEmpresasSubraiTranfDef : Boolean;
    function fRetEmpresasSelLoc(AcdsEmpSel: TUniClientDataSet; strCampo: String; blnIncluirMarcados: Boolean = True): String;
  public
    { Public declarations }
    procedure pAjustachkPedPenTransferencia;
    function fRetEmpSel: String;

    procedure pCarregaEmpresas;
  end;

implementation

{$R *.dfm}

Uses
  Uni,
  untFuncoesSimples, untSelEmpresas;

procedure TfraCalcGirFrame.cdsEmpSelBeforePost(DataSet: TDataSet);
begin

  With DataSet Do
  If FieldByName('MARDES').AsString = 'S' Then
    FieldByName('EMPVIS').AsString := 'S';

end;

procedure TfraCalcGirFrame.chkAgrEmpClick(Sender: TObject);
begin

  cbxAbrEmp.Enabled := chkAgrEmp.Checked;
  rdgSugInd.Enabled := chkAgrEmp.Checked;

end;

procedure TfraCalcGirFrame.chkAteMaxClick(Sender: TObject);
begin

  If chkAteMax.Checked Then
    chkEstMax.Checked := False;

end;

procedure TfraCalcGirFrame.chkEstMaxClick(Sender: TObject);
begin

  If chkEstMax.Checked Then
    chkAteMax.Checked := False;

end;

procedure TfraCalcGirFrame.chkEstMinClick(Sender: TObject);
begin

  If chkEstMin.Checked Then
    chkPonPed.Checked := False;

end;

procedure TfraCalcGirFrame.chkMultCompraClick(Sender: TObject);
begin
  chkMultiploAposCentralizar.Enabled := chkMultCompra.Checked;

  If Not chkMultiploAposCentralizar.Enabled Then
    chkMultiploAposCentralizar.Checked := False;
end;

procedure TfraCalcGirFrame.pAjustachkPedPenTransferencia;
Begin
  chkPedPenTransferencia.Enabled := chkPedPen.Checked;
  chkPedGar.Enabled :=  chkPedPen.Checked;

  If Not chkPedPenTransferencia.Enabled Then
  Begin
    chkPedPenTransferencia.Checked := False;
    chkPedGar.Checked :=  chkPedPen.Checked;
  End;
End;


procedure TfraCalcGirFrame.chkPedPenClick(Sender: TObject);
begin
  pAjustachkPedPenTransferencia;
end;

procedure TfraCalcGirFrame.chkPedPenTransferenciaClick(Sender: TObject);
begin
 lblLinkEmpresas.Visible := chkPedPenTransferencia.Checked;
end;

procedure TfraCalcGirFrame.chkPedVenClick(Sender: TObject);
begin
  If chkPedVen.Checked And fEmptyStr(edtDiaPre.Text) Then
    edtDiaPre.Text := '999';

  edtDiaPre.Enabled     := chkPedVen.Checked;
  lblConsiderar.Enabled := chkPedVen.Checked;
  lblDiasPrev.Enabled   := chkPedVen.Checked;

  If Not edtDiaPre.Enabled Then
    edtDiaPre.Clear;
end;

procedure TfraCalcGirFrame.chkPonPedClick(Sender: TObject);
begin

  If chkPonPed.Checked Then
    chkEstMin.Checked := False;

end;

function TfraCalcGirFrame.fRetEmpSel: String;
begin

    cdsEmpSubtraiTansf.First;
    Result := '';
    While Not cdsEmpSubtraiTansf.Eof Do
    Begin
      If cdsEmpSubtraiTansf.FieldByName('MARDES').AsString = 'M' Then
        Result := Result + '_' + (cdsEmpSubtraiTansf.FieldByName('EMP_CODEMP').AsString);
      cdsEmpSubtraiTansf.Next;
    End;
end;

function TfraCalcGirFrame.fRetEmpresasSelLoc(AcdsEmpSel: TUniClientDataSet; strCampo: String; blnIncluirMarcados: Boolean = True): String;
  Var
    stlLista: TStringList;
Begin
  stlLista := TStringList.Create;

  AcdsEmpSel.First;
  While Not AcdsEmpSel.Eof Do
  Begin
    If (AcdsEmpSel.FieldByName(strCampo).AsString = 'S') Then
      stlLista.Add(AcdsEmpSel.FieldByName('CODEMP').AsString)

    Else If blnIncluirMarcados And SameText(strCampo, 'EMPVIS') And
           (AcdsEmpSel.FieldByName('MARDES').AsString = 'S') Then
          stlLista.Add(AcdsEmpSel.FieldByName('CODEMP').AsString);

    AcdsEmpSel.Next;
  End;

  Result := fCommaText(stlLista, True);

  stlLista.Clear;
  FreeAndNil(stlLista);
End;


procedure TfraCalcGirFrame.lblLinkEmpresasClick(Sender: TObject);
var frmSelEmpresas: TfrmSelEmpresas;
    strEmpSel: String;

    cdsDadosBkp: TUniClientDataSet;
begin
  cdsDadosBkp := TUniClientDataSet.Create(nil);
  pCriarFormularios(TfrmSelEmpresas, frmSelEmpresas);
  Try
    If Not blnEmpresasSubraiTranfDef Then
    Begin
      strEmpSel := fRetEmpresasSelLoc(cdsEmpSel, 'MARDES', False);
      cdsEmpSubtraiTansf.First;
      While Not cdsEmpSubtraiTansf.Eof Do
      Begin
        cdsEmpSubtraiTansf.Edit;
        If Pos(cdsEmpSubtraiTansf.FieldByName('EMP_CODEMP').AsString, strEmpSel) > 0 Then
          cdsEmpSubtraiTansf.FieldByName('MARDES').AsString := 'M'
        Else
          cdsEmpSubtraiTansf.FieldByName('MARDES').AsString := 'D';
        cdsEmpSubtraiTansf.Post;
        cdsEmpSubtraiTansf.Next;
      End;

    End;

    cdsDadosBkp.Data := cdsEmpSubtraiTansf.Data;
    frmSelEmpresas.dsCadEmp.DataSet := cdsDadosBkp;
    frmSelEmpresas.cxGridEmpresasTableCODEMP.SortOrder := soAscending;
    frmSelEmpresas.ShowModal;
    If frmSelEmpresas.ModalResult = 1 Then
    Begin
      blnEmpresasSubraiTranfDef := True;
      cdsEmpSubtraiTansf.Data := cdsDadosBkp.Data;
    End;
  Finally
    FreeAndNil(frmSelEmpresas);
    FreeAndNil(cdsDadosBkp);
  End;
end;

procedure TfraCalcGirFrame.pCarregaEmpresas;
  Var
    qryGenEmp: TUniQuery;
begin

  blnEmpresasSubraiTranfDef := False;

  qryGenEmp := fCriaQuery(Nil);

  {*****************************************}
  {* CARREGA COMBO BOX                     *}
  {**************************************AF*}
  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT CONCAT(EMP_CODEMP, "-", EMP_NOMEMP) FROM CADEMP WHERE EMP_EMPATI = "S" ORDER BY EMP_CODEMP ');
    Open;

    cbxAbrEmp.Items.Clear;
    cbxAbrEmp.Items.Add('Centralizada');

    While Not Eof Do
    Begin
      cbxAbrEmp.Items.Add(Fields[0].AsString);
      Next;
    End;

    cbxAbrEmp.ItemIndex := 0;
  End;

  {*****************************************}
  {* CARREGA GRID                          *}
  {**************************************AF*}
  With qryGenEmp Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(' SELECT * FROM CADEMP WHERE EMP_EMPATI = "S" ORDER BY EMP_CODEMP ');
    Open;

    cdsEmpSel.CreateDataSet;
    cdsEmpSubtraiTansf.CreateDataSet;

    While Not Eof Do
    Begin
      cdsEmpSel.Append;
      cdsEmpSel.FieldByName('CODEMP').AsString := FieldByName('EMP_CODEMP').AsString;
      cdsEmpSel.FieldByName('DESCRI').AsString := FieldByName('EMP_NOMEMP').AsString;
      cdsEmpSel.FieldByName('MARDES').AsString := 'S';
      cdsEmpSel.Post;
      cdsEmpSubtraiTansf.Append;
      cdsEmpSubtraiTansf.FieldByName('EMP_CODEMP').AsString := FieldByName('EMP_CODEMP').AsString;
      cdsEmpSubtraiTansf.FieldByName('EMP_NOMEMP').AsString := FieldByName('EMP_NOMEMP').AsString;
      cdsEmpSubtraiTansf.FieldByName('MARDES').AsString := 'D';
      cdsEmpSubtraiTansf.Post;
      Next;
    End;

    cdsEmpSel.First;
    cdsEmpSubtraiTansf.First;
  End;

  FreeAndNil(qryGenEmp);

end;


end.
