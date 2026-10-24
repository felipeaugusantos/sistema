unit untEntEnderecamentoArmazens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiConfirma, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls,
  cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  DB, cxDBData, cxGridLevel, cxClasses, cxControls, cxGridCustomView,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxGrid, EditFocus,
  UniClientDataSet, Math, BitBtnLockedIncrem, cxLookAndFeels,
  cxLookAndFeelPainters, cxNavigator, frxClass, frxExportCSVTestabilidade,
  untEnderecamentoArmazem,untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog, Uni;

type
  TfrmEntEnderecamentoArmazens = class(TfrmPaiConfirma)
    pnlCabec: TPanel;
    cxgItensView: TcxGridDBTableView;
    cxgItensLevel1: TcxGridLevel;
    cxgItens: TcxGrid;
    cxgItensNUMLOT: TcxGridDBColumn;
    cxgItensLOCFIS: TcxGridDBColumn;
    cxgItensDTAVAL: TcxGridDBColumn;
    cxgItensCAPACI: TcxGridDBColumn;
    cxgItensSALDOS: TcxGridDBColumn;
    cxgItensQTDITE: TcxGridDBColumn;
    cxgItensQTDTOT: TcxGridDBColumn;
    Label1: TLabel;
    edtQtdIte: TEditFocus;
    Label2: TLabel;
    edtCodIte: TEditFocus;
    pnlRodape: TPanel;
    dtsItens: TDataSource;
    btnCadRapLotWMS: TBitBtnLocked;
    chkExiSemSal: TCheckBox;
    btnLocFis: TBitBtnLocked;
    cxgItensAmzDes: TcxGridDBColumn;
    cxgItensDTAFAB: TcxGridDBColumn;
    btnAtualizar: TBitBtnLocked;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnCadRapLotWMSClick(Sender: TObject);
    procedure chkExiSemSalClick(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure btnLocFisClick(Sender: TObject);
    procedure btnAtualizarClick(Sender: TObject);
  private
    { Private declarations }
    intDecQtd: Integer;
    Function fRetNomeArmazem(Var strLocali: String): String;
    procedure pAtualizarLocalizacaoFisica;
    function fLoteLocalizacaoFisica(strCodEmp, strCodIte,
      strNumLot: String): String;
    procedure pBeforePost(DataSet: TDataSet);
  public
    { Public declarations }
    strCodIte: String;
    strAutInc: String;
    strArmOri: String;
    fltQtdIte: Double;

    cdsItens : TUniClientDataSet;
    objEndArm: TEnderecamentoArmazem;
    strAmzDes: String;

    strNumLot: String;
    strLocFis: String;
    strAutEnt: String;
  end;

var
  frmEntEnderecamentoArmazens: TfrmEntEnderecamentoArmazens;

implementation

uses  untFuncoesSimples, untCadLoteItens, untCadLocFisica;

{$R *.dfm}

procedure TfrmEntEnderecamentoArmazens.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10   : Begin
                 Key := 0;
                 btnConfirma.Click;
               End;

    VK_F8    : Begin
                 Key := 0;
                 btnCadRapLotWMS.Click;
               End;

    VK_F7 : Begin
              Key := 0;
              btnLocFis.Click;
            End;

    VK_F5   : Begin
                 Key := 0;
                 btnAtualizar.Click;
               End;

    VK_RETURN: If cxgItensQTDITE.Focused And (cdsItens.State = dsEdit) Then
               Begin
                 cdsItens.Next;
               End;
  End;
end;

procedure TfrmEntEnderecamentoArmazens.FormShow(Sender: TObject);
begin
  inherited;
  intDecQtd := fCfgSis('DEQTEM');

  dtsItens.DataSet       := cdsItens;
  pAtualizarLocalizacaoFisica;
  cxgItensQTDITE.Focused := True;
  cxgItensAmzDes.Visible := ((fCfgSis('CONFME') = '1') And (fCfgSis('CTLEST') = '2'));

  If fUsaRotinaWMS or (fExisteLote(strCodIte, VS_strCodEmp) and fCfgSis('CTLEST') = '1') Then
  Begin
    Caption := 'Informe os Lotes para a transferência';
    cxgItensNUMLOT.Caption  := 'Lote';
    cxgItensCAPACI.Visible  := False;
    cxgItensDTAVAL.Visible  := True;
    btnCadRapLotWMS.Visible := True;
    btnLocFis.Visible       := True;
    chkExiSemSal.Visible    := True;
  End
  Else
  Begin
    Caption := 'Informe os Armazéns para a transferência';
    cxgItensNUMLOT.Caption := 'Armazém';
    cxgItensDTAVAL.Visible  := False;
    btnCadRapLotWMS.Visible := False;
    btnLocFis.Visible       := False;
    chkExiSemSal.Visible    := False;
  End;

  pnlRodape.Visible := chkExiSemSal.Visible;

  chkExiSemSalClick(nil);
  cxgItensView.DataController.Summary.FooterSummaryItems[0].Format := fMskDigitos(fCfgSis('DEQTEM', varInteger));

  cdsItens.BeforePost := pBeforePost;
end;

Function TfrmEntEnderecamentoArmazens.fRetNomeArmazem(Var strLocali: String): String;
Begin
  Result := '';
  strLocali := '';
  With cdsItens Do
  Begin
    DisableControls;
    First;
    While Not Eof Do
    Begin
      If (FieldByName('QTDITE').AsFloat > 0) Then
      Begin
        If fEmptyStr(Result) Then
        Begin
          Result    := FieldByName('ARMDES').AsString;
          strLocali := FieldByName('LOCFIS').AsString;
          strAmzDes := FieldByName('AMZDES').AsString;

        End Else
        Begin
          Result := 'VÁRIOS';
          strLocali := '';
          strAmzDes := '';
          Break;
        End;
      End;

      Next;
    End;

    EnableControls;
  End;
End;

procedure TfrmEntEnderecamentoArmazens.btnAtualizarClick(Sender: TObject);
begin
  inherited;
  pAtualizarLocalizacaoFisica;
end;

procedure TfrmEntEnderecamentoArmazens.btnCadRapLotWMSClick(Sender: TObject);
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    strLotCad: String;
    blnFilter: Boolean;
    fltQtdDig: Double;
begin
  inherited;
  If Not btnCadRapLotWMS.Visible Then
    Exit;

  If Not fVerificaAcessoSistema('frmCadLoteItensRapido') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  Try
    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS := strCodIte;
    frmCadLoteItens.ShowModal;
    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;
  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadLoteItens);

  //Caso gravou um novo Lote para o produto
  If Not fEmptyStr(strLotCad) Then
  Begin
    //Atualiza os lotes do produto no enderecamento
    objEndArm.pAtualizaArmazemItem(strCodIte, strAutInc, strArmOri, fltQtdIte);

    //Caso esteja filtrado para nao mostrar sem saldos
    blnFilter := cdsItens.Filtered;
    cdsItens.Filtered := False;

    //Atualiza os lotes do produto no clientdataset sendo digitado
    cdsItens.BeforePost := nil;
    objEndArm.pCopiarItens(cdsItens, strCodIte, strAutInc, strLotCad);
    cdsItens.BeforePost := pBeforePost;

    //Caso encontre o novo lote cadastrado
    If cdsItens.Locate('CODITE;NUMLOT;AUTINC',
                       VarArrayOf([strCodIte, strLotCad, strAutInc]), []) And

       Not fEmptyStr(cdsItens.FieldByName('LOCFIS').AsString) Then
    Begin
      fltQtdDig := fDoubleAggregate(cdsItens, 'TOTDIG');

      //Caso ainda tenha quantidade a ser digitada atualiza a mesma no novo lote que foi cadastrado
      If RoundTo((fltQtdIte - fltQtdDig), -intDecQtd) > 0 Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('QTDITE').AsFloat := RoundTo((fltQtdIte - fltQtdDig), -intDecQtd);
        cdsItens.Post;
      End;

    End;

    cdsItens.Filtered := blnFilter;
  End;

end;

procedure TfrmEntEnderecamentoArmazens.btnConfirmaClick(Sender: TObject);
begin
  If chkExiSemSal.Visible Then
  Begin
    cdsItens.Filter   := '';
    cdsItens.Filtered := False;
  End;

  inherited;
end;

procedure TfrmEntEnderecamentoArmazens.btnLocFisClick(Sender: TObject);
begin
  inherited;
  If Not fVerificaAcessoSistema('frmCadLocFisica') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Localização Física!', ['&O k']);
    Exit;
  End;

  pCriarForm(TfrmCadLocFisica);

end;

procedure TfrmEntEnderecamentoArmazens.chkExiSemSalClick(Sender: TObject);
begin
  inherited;
  If Not chkExiSemSal.Visible Then
    Exit;

  If Not chkExiSemSal.Checked Then
  Begin
    //Exibe os que possuem saldo ou que possuem alguma quantidade digitada
    cdsItens.Filter   := '((SALDOS > 0) OR (QTDITE > 0))';
    cdsItens.Filtered := True;
  End
  Else
  Begin
    cdsItens.Filter   := '';
    cdsItens.Filtered := False;
  End;

end;

procedure TfrmEntEnderecamentoArmazens.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If ModalResult = mrOk Then
  Begin
    If dtsItens.DataSet.State = dsEdit Then
      dtsItens.DataSet.Post;

    If RoundTo(fltQtdIte, -intDecQtd) < RoundTo(fDoubleAggregate(cdsItens, 'TOTDIG'), -intDecQtd) Then
    Begin
      pMensagemOk('A soma das quantidades digitadas excede o total a ser transferido!');
      pSetFocus(cxgItens);
      cxgItensQTDITE.Focused := True;
      Action := caNone;
    End;

    If RoundTo(fltQtdIte, -intDecQtd) > RoundTo(fDoubleAggregate(cdsItens, 'TOTDIG'), -intDecQtd) Then
    Begin
      strNumLot := 'A DEFINIR';
      strLocFis := '';
      pMensagemOk('A quantidade a transferir ainda não está completa!');
    End

    Else strNumLot := fRetNomeArmazem(strLocFis);

  End;

end;

Procedure TfrmEntEnderecamentoArmazens.pAtualizarLocalizacaoFisica;
Var pBeforePost: TDataSetNotifyEvent;
Begin
  cdsItens.DisableControls;
  pBeforePost := cdsItens.BeforePost;
  Try
    cdsItens.BeforePost := Nil;
    cdsItens.First;
    While Not cdsItens.Eof Do
    Begin
      If fEmptyStr(cdsItens.FieldByName('LOCFIS').AsString) Then
      Begin
        cdsItens.Edit;
        cdsItens.FieldByName('LOCFIS').AsString := fLoteLocalizacaoFisica(VS_strCodEmp,
          cdsItens.FieldByName('CODITE').AsString,
          cdsItens.FieldByName('NUMLOT').AsString);
        cdsItens.Post;
      End;
      cdsItens.Next;
    End;
  Finally
    cdsItens.EnableControls;
    cdsItens.First;
    cdsItens.BeforePost := pBeforePost;
  End;
End;

procedure TfrmEntEnderecamentoArmazens.pBeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('AUTENT').AsString := strAutEnt;
  If Not objEndArm.fValidaArmazem(DataSet, True, DataSet.FieldByName('QTDITE').AsFloat) Then
    Abort;
end;

function TfrmEntEnderecamentoArmazens.fLoteLocalizacaoFisica(strCodEmp, strCodIte, strNumLot: String): String;
Var
  qryGenTemp: TUniQuery;
Begin
  qryGenTemp:= fCriaQuery(Self);
  Try
    qryGenTemp.Close;
    qryGenTemp.SQL.Add('SELECT LOT_LOCFIS FROM CADLOT WHERE LOT_CODITE = :CODITE AND LOT_CODEMP = :CODEMP AND LOT_NUMLOT = :NUMLOT');
    qryGenTemp.ParamByName('CODITE').AsString:= strCodIte;
    qryGenTemp.ParamByName('CODEMP').AsString:= strCodEmp;
    qryGenTemp.ParamByName('NUMLOT').AsString:= strNumLot;
    qryGenTemp.Open;

    Result := qryGenTemp.FieldByName('LOT_LOCFIS').AsString;
  Finally
    if AsSigned(qryGenTemp) then
      FreeAndNil(qryGenTemp);
  End;
End;



end.


