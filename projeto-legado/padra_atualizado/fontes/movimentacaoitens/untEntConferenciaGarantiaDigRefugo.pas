unit untEntConferenciaGarantiaDigRefugo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels, Uni,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridLevel,
  cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses,
  cxGridCustomView, cxGridCitel, cxGrid, untZClient,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmEntConferenciaGarantiaDigRefugo = class(TfrmPaiConfirma)
    cxgRefugo: TcxGridCitel;
    cxgRefugoTableView: TcxGridDBTableViewCitel;
    cxgRefugoNUMDOC: TcxGridDBColumn;
    cxgRefugoDTAENT: TcxGridDBColumn;
    cxgRefugoCODITE: TcxGridDBColumn;
    cxgRefugoDESITE: TcxGridDBColumn;
    cxgRefugoCODFAB: TcxGridDBColumn;
    cxgRefugoREFERE: TcxGridDBColumn;
    cxgRefugoSIGUNI: TcxGridDBColumn;
    cxgRefugoQTDITE: TcxGridDBColumn;
    cxgRefugoQTDREF: TcxGridDBColumn;
    cxgRefugoLevel: TcxGridLevel;
    procedure cxgRefugoExit(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
  private
    cdsRefugo : TZClient;
    function fGetSQL(stlPedido: TStringList):String;
    procedure pBeforePost(DataSet : TDataSet);
  public
    class function fDigitaRefugos(stlPedido : TStringList) : Boolean;
  end;

implementation

{$R *.dfm}

uses untFuncoesSimples;

{ TfrmEntConferenciaGarantiaDigRefugo }


procedure TfrmEntConferenciaGarantiaDigRefugo.btnConfirmaClick(Sender: TObject);
  Var
    qryUpdate : TUniQuery;
begin
  //inherited;
  Try
    qryUpdate := fCriaQuery(Self);
    cdsRefugo.DisableControls;
    With qryUpdate, SQL Do
    Begin
      Close;
      Clear;
      Add(' UPDATE PCMDET SET PCD_QTDREF = IFNULL(PCD_QTDREF,0) + :QTDREF WHERE AUTOINCREM = :AUTINC ');

      cdsRefugo.First;
      While Not cdsRefugo.Eof Do
      Begin
        ParamByName('QTDREF').AsFloat  := cdsRefugo.FieldByName('QTDREF').AsFloat;
        ParamByName('AUTINC').AsString := cdsRefugo.FieldByName('AUTINC').AsString;
        ExecSQL;

        cdsRefugo.Next;
      End;

      ModalResult := MrOk;

    End;

  Finally
    cdsRefugo.EnableControls;
    FreeAndNil(qryUpdate);
  End;

end;

procedure TfrmEntConferenciaGarantiaDigRefugo.cxgRefugoExit(Sender: TObject);
begin
  inherited;
  cdsRefugo.CheckBrowseMode;
end;

Class function TfrmEntConferenciaGarantiaDigRefugo.fDigitaRefugos(stlPedido: TStringList): Boolean;
  var
    frmFrm : TfrmEntConferenciaGarantiaDigRefugo;
begin
  Result := False;
  If stlPedido.Count <= 0 Then
    Exit;

  pCriarFormularios(TfrmEntConferenciaGarantiaDigRefugo,frmFrm);
  With frmFrm Do
  Begin
    cdsRefugo := TZClient.Create(frmFrm, fGetSQL(stlPedido));
    cdsRefugo.fAbreClient(True);

    If Not cdsRefugo.IsEmpty Then
    Begin
      TFLoatField(cdsRefugo.FieldByName('QTDITE')).DisplayFormat := '#,##0.00';
      TFLoatField(cdsRefugo.FieldByName('QTDREF')).DisplayFormat := '#,##0.00';
      cdsRefugo.BeforePost := pBeforePost;

      cxgRefugoTableView.DataController.DataSource := cdsRefugo.dtsSource;
      cxgRefugoTableView.ApplyBestFit();
      Result := (ShowModal = MrOk);
    End;

  End;
  FreeAndNil(frmFrm);

end;

function TfrmEntConferenciaGarantiaDigRefugo.fGetSQL(stlPedido: TStringList): String;
  Var
    intIndex : Integer;
begin
  Result := '';
  Result := Result + ' SELECT PCD_NUMPED AS NUMDOC,                          ';
  Result := Result + '        PCD_DTAENT AS DTAENT,                          ';
  Result := Result + '        PCD_CODITE AS CODITE,                          ';
  Result := Result + '        ITE_DESITE AS DESITE,                          ';
  Result := Result + '        ITE_CODFAB AS CODFAB,                          ';
  Result := Result + '        ITE_REFERE AS REFERE,                          ';
  Result := Result + '        UNI_SIGUNI AS SIGUNI,                          ';
  Result := Result + '        PCD_QTDITE AS QTDITE,                          ';
  Result := Result + '        PCD_QTDREF AS QTDREF,                          ';
  Result := Result + '        D.AUTOINCREM AS AUTINC                         ';
  Result := Result + ' FROM PCMDET D                                         ';
  Result := Result + '   LEFT  JOIN CADITE ON ITE_CODITE = PCD_CODITE        ';
  Result := Result + '   LEFT  JOIN CADUNI ON UNI_CODUNI = ITE_CODUNI        ';
  Result := Result + ' WHERE PCD_CODEMP = ' + QuotedStr(VS_strCodEmp);
  Result := Result + '   AND PCD_ESPDOC = "PD" ';
  Result := Result + '   AND PCD_NUMCTN = 0 ';

  If (stlPedido.Count = 1) Then
    Result := Result + ' AND PCD_NUMPED = ' + QuotedStr(stlPedido[0])
  Else
  Begin
    Result := Result + ' AND PCD_NUMPED IN( ';
    For intIndex := 0 To stlPedido.Count - 1 Do
    Begin
      Result := Result + QuotedStr(stlPedido[intIndex]);
      If intIndex < stlPedido.Count - 1 Then
        Result := Result + ', ';
    End;
    Result := Result + ') ';
  End;


end;

procedure TfrmEntConferenciaGarantiaDigRefugo.pBeforePost(DataSet: TDataSet);
begin
  If cdsRefugo.FieldByName('QTDITE').AsFloat < cdsRefugo.FieldByName('QTDREF').AsFloat Then
  Begin
    fMensagem('','A quantidade de refugo não pode ser maior que a quantidade da nota fiscal!', ['&Ok']);
    cdsRefugo.FieldByName('QTDREF').AsFloat := cdsRefugo.FieldByName('QTDITE').AsFloat;
    pSetFocus(cxgRefugo);
  End

  Else If cdsRefugo.FieldByName('QTDREF').AsFloat < 0 Then
    cdsRefugo.FieldByName('QTDREF').AsFloat := 0;

end;

end.
