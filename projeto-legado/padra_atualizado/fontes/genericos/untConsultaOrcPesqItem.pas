unit untConsultaOrcPesqItem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator, Data.DB, cxDBData, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCustomView, cxGridCitel, cxClasses,
  cxGridLevel, cxGrid, Vcl.ExtCtrls, frxClass, frxExportCSVTestabilidade,
  Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons, BitBtnLockedIncrem, Uni, untTypesSistema,
  cxDataControllerConditionalFormattingRulesManagerDialog;

type
  TfrmConsultaOrcPesqItem = class(TfrmPai)
    dbgOrcamentosLevel1: TcxGridLevel;
    dbgOrcamentosView: TcxGridDBTableViewCitel;
    dbgOrcamentos: TcxGridCitel;
    dtsOrcamentos: TDataSource;
    dbgOrcamentosNumDoc: TcxGridDBColumn;
    dbgOrcamentosEspDoc: TcxGridDBColumn;
    dbgOrcamentosCodEmp: TcxGridDBColumn;
    dbgOrcamentosCodVen: TcxGridDBColumn;
    dbgOrcamentosDtaEnt: TcxGridDBColumn;
    dbgOrcamentosNomCLi: TcxGridDBColumn;
    dbgOrcamentosQtdIte: TcxGridDBColumn;
    dbgOrcamentosTabPre: TcxGridDBColumn;
    dbgOrcamentosUnitar: TcxGridDBColumn;
    dbgOrcamentosTotIte: TcxGridDBColumn;
    btnDocCom: TBitBtnLocked;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgOrcamentosViewKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnDocComClick(Sender: TObject);
  private
    { Private declarations }
    qryTemp: TUniQuery;

    Const
      SQL_ORC = 'SELECT DISTINCT ' +
                   ' FDO_NUMDOC AS NUMDOC, ' +
                   ' FDO_ESPDOC AS ESPDOC, ' +
                   ' FDO_CODEMP AS CODEMP, ' +
                   ' FDO_CODVEN AS CODVEN, ' +
                   ' FDO_DTAENT AS DTAENT, ' +
                   ' CONCAT(FDO_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ' +
                   ' FDO_TABPRE AS TABPRE, ' +
                   ' FDO_UNITAR AS UNITAR, ' +
                   ' FDO_TOTITE AS TOTITE, ' +
                   ' FDO_QTDITE AS QTDITE ' +
                 ' FROM ' +
                 '   FATDOR ' +
                 '     INNER JOIN CADEMP ON FDO_CODEMP = EMP_CODEMP ' +
                 '     INNER JOIN CADOPE ON FDO_CODVEN = OPE_CODOPE ' +
                 '     INNER JOIN CADCLI ON FDO_CODCLI = CLI_CODCLI ' +
                 ' WHERE FDO_ESPDOC = "OR" ' +
                 '   AND FDO_JAFATU = 0 ' +
                 '   AND FDO_CODITE = :CODITE ' +
                 '   AND FDO_CODEMP = :CODEMP ' +
                 ' ORDER BY FDO_DTAENT ';
  public
    { Public declarations }
    sDesIte: String;
    sCodIte: String;
    pMostraDocumentoReimpressao: TMostraDocumentoReimpressao;

    Class Procedure pMostraOrcamento(strCodIte, strDesIte: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);
  end;

var
  frmConsultaOrcPesqItem: TfrmConsultaOrcPesqItem;

implementation

{$R *.dfm}

uses untFuncoesSimples;

procedure TfrmConsultaOrcPesqItem.btnDocComClick(Sender: TObject);
begin

  inherited;

  If Not btnDocCom.Visible Then
    Exit;

  If Not Assigned(pMostraDocumentoReimpressao) Then
    Exit;

  With dtsOrcamentos.DataSet Do
  Begin
    pMostraDocumentoReimpressao(FieldByName('NUMDOC').AsString,
                                FieldByName('ESPDOC').AsString,
                                FieldByName('CODEMP').AsString,
                                '');
  End;

end;

procedure TfrmConsultaOrcPesqItem.dbgOrcamentosViewKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_Escape) Then
    btnSair.Click()
  Else If (Key = VK_F5) Then
    btnDocCom.Click;

end;

procedure TfrmConsultaOrcPesqItem.FormCreate(Sender: TObject);
begin
  inherited;

  sDesIte := '';
  sCodIte := '';

  qryTemp := fCriaQuery(Self);

  dtsOrcamentos.DataSet := qryTemp;
end;

procedure TfrmConsultaOrcPesqItem.FormDestroy(Sender: TObject);
begin
  inherited;
  FreeAndNil(qryTemp);
end;

procedure TfrmConsultaOrcPesqItem.FormShow(Sender: TObject);
begin
  inherited;

  Try
    qryTemp.Close();
    qryTemp.SQL.CLear();
    qryTemp.SQL.Add(SQL_ORC);
    qryTemp.ParamByName('CODITE').AsString := sCodIte;
    qryTemp.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qryTemp.Open;

    TFloatField(qryTemp.FieldByName('QTDITE')).DisplayFormat := '#,####0.0000';
    TFloatField(qryTemp.FieldByName('UNITAR')).DisplayFormat := '#,##0.00';
    TFloatField(qryTemp.FieldByName('TOTITE')).DisplayFormat := '#,##0.00';

    Self.Caption := Self.Caption + ': ' + sCodIte + '-' + sDesIte;

    dbgOrcamentosView.ApplyBestFit();
  Except
    On E: Exception Do Begin
      pMensagensErro(E.Message, '[TfrmConsultaOrcPesqItem.FormShow]');
    End;
  End;

  btnDocCom.Visible := Assigned(pMostraDocumentoReimpressao);
  pSetFocus(dbgOrcamentos);
end;

Class Procedure TfrmConsultaOrcPesqItem.pMostraOrcamento(strCodIte, strDesIte: String; procMostraDocumentoReimpressao: TMostraDocumentoReimpressao);
Begin
  Try
    pCriarFormularios(TfrmConsultaOrcPesqItem, frmConsultaOrcPesqItem);
    frmConsultaOrcPesqItem.sCodIte := strCodIte;
    frmConsultaOrcPesqItem.sDesIte := strDesIte;
    frmConsultaOrcPesqItem.pMostraDocumentoReimpressao := procMostraDocumentoReimpressao;
    frmConsultaOrcPesqItem.ShowModal();
  Finally
    FreeAndNil(frmConsultaOrcPesqItem);
  End;
End;

end.
