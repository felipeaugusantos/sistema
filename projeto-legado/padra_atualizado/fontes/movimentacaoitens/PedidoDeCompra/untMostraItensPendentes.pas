unit untMostraItensPendentes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, AppEvnts, Menus, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridCitel, DBGrids, DB, StrUtils, Math, BitBtnLockedIncrem, frxClass,
  frxExportCSVTestabilidade,  UniClientDataSet, Uni, EditFocus;

type

  TfrmMostraItensPendentes = class(TfrmPai)
    dtsPedido: TDataSource;
    dbgItens: TDBGridCitel;
    Shape1: TShape;
    Label1: TLabel;
    Shape2: TShape;
    Label2: TLabel;
    Panel1: TPanel;
    lblTotal: TLabel;
    edtTotal: TEditFocus;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbgItensDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
    class procedure pMostraItensPendentes(strNumeroPedido, strEspecie, strEmpresa: string);

  end;

var
  frmMostraItensPendentes: TfrmMostraItensPendentes;
  intDecTpc: Integer;

implementation

uses untFuncoesSimples, System.UITypes;

{$R *.dfm}

procedure TfrmMostraItensPendentes.dbgItensKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  If Key = VK_ESCAPE Then
    btnSair.Click;
end;

class procedure TfrmMostraItensPendentes.pMostraItensPendentes(strNumeroPedido,
  strEspecie, strEmpresa: string);
  Var
    qryAux: TUniQuery;

    Procedure pCarregaItens(blnTotal: Boolean);
    Begin
      qryAux.Close;

      qryAux.SQL.Clear;

      qryAux.SQL.Add('SELECT ');

      If Not blnTotal Then
      Begin
        qryAux.SQL.Add('  PCD_CODITE, ');
        qryAux.SQL.Add('  PCD_DESITE, ');
        qryAux.SQL.Add('  IFNULL(PCD_DTAENT, PCD_DTAEDT) AS PCD_DTAEDT, ');
        qryAux.SQL.Add('  PCD_EMBALA, ');
        qryAux.SQL.Add('  MAR_DESMAR, ');
        qryAux.SQL.Add('  CAST("" AS CHAR(12)) AS DOCENT, ');

        If fCfgSis('TABPRF', VarBoolean) Then
          qryAux.SQL.Add(' IF(F.ITE_CODITE IS NULL, C.ITE_CODFAB, F.ITE_CODFAB) AS ITE_CODFAB, ')
        Else
          qryAux.SQL.Add(' IFNULL((SELECT F.ITE_CODITF FROM ITEFOR F WHERE F.ITE_CODITE = C.ITE_CODITE AND F.ITE_CODFOR = PCD_CODFOR AND IFNULL(F.ITE_CODITF, "") <> "" LIMIT 1), C.ITE_CODFAB) AS ITE_CODFAB, ');

        qryAux.SQL.Add('  UNI_SIGUNI, ');
        qryAux.SQL.Add('  FORMAT(PCD_QTDITE, ' + IntToStr(intDecTpc) + ') AS PCD_QTDITE, ');
        qryAux.SQL.Add('  FORMAT(PCD_QTDBAI, ' + IntToStr(intDecTpc) + ') AS PCD_QTDBAI, ');

        qryAux.SQL.Add('  PCD_QTDBAI  AS PCD_QTDBAI_NO_FORMAT, ');
        qryAux.SQL.Add('  IF(PCD_QTDBAI > PCD_QTDITE, 0, PCD_QTDITE - PCD_QTDBAI) AS PCD_QTDRES_NO_FORMAT, ');

        qryAux.SQL.Add('  FORMAT(IF(PCD_QTDBAI > PCD_QTDITE, 0, PCD_QTDITE - PCD_QTDBAI), 2) AS PCD_QTDRES, ');

        qryAux.SQL.Add('  (ROUND(PCD_UNITAR * ');
        qryAux.SQL.Add('      (  (1 - IFNULL(PCD_DESUNI, 0) / 100) ');
        qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN2, 0) / 100) ');
        qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN3, 0) / 100) ');
        qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN4, 0) / 100) ');
        qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN5, 0) / 100) ');
        qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN6, 0) / 100) ');
        qryAux.SQL.Add('       ), :DECUNI)) AS UNILIQ, ');
      End;

      If blnTotal Then
        qryAux.SQL.Add('  SUM(');

      qryAux.SQL.Add('ROUND(PCD_UNITAR * ');
      qryAux.SQL.Add('      (  (1 - IFNULL(PCD_DESUNI, 0) / 100) ');
      qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN2, 0) / 100) ');
      qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN3, 0) / 100) ');
      qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN4, 0) / 100) ');
      qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN5, 0) / 100) ');
      qryAux.SQL.Add('       * (1 - IFNULL(PCD_DESUN6, 0) / 100) ');
      qryAux.SQL.Add('       ), :DECUNI) * ');
      qryAux.SQL.Add('        IF(PCD_QTDBAI > PCD_QTDITE, 0, PCD_QTDITE - PCD_QTDBAI)');

      If blnTotal Then
        qryAux.SQL.Add(')');

      qryAux.SQL.Add(' AS TOTRES ');

      qryAux.SQL.Add('FROM ');
      qryAux.SQL.Add('  PCMDET ');
      qryAux.SQL.Add('  JOIN CADITE C ON C.ITE_CODITE = PCD_CODITE ');
      qryAux.SQL.Add('  LEFT JOIN CADMAR ON MAR_CODMAR = ITE_CODMAR ');
      qryAux.SQL.Add('  JOIN CADUNI ON UNI_CODUNI = IFNULL(PCD_CODUNI, ITE_CODUNI) ');

      If fCfgSis('TABPRF', VarBoolean) Then
      Begin
        qryAux.SQL.Add('  LEFT JOIN ITEFOR F ON F.ITE_CODITE = C.ITE_CODITE AND ');
        qryAux.SQL.Add('                        F.ITE_CODFOR = PCD_CODFOR AND ');
        qryAux.SQL.Add('                        (SELECT COUNT(*) FROM TABPRE      ');
        qryAux.SQL.Add('                         WHERE F.ITE_CODTAB = TAB_CODTAB AND TAB_ATICMP = "S") > 0 ');
      End;

      qryAux.SQL.Add('WHERE ');
      qryAux.SQL.Add('  PCD_NUMPED = :NUMPED AND ');
      qryAux.SQL.Add('  PCD_ESPDOC = :ESPDOC AND ');
      qryAux.SQL.Add('  PCD_CODEMP = :CODEMP AND ');
      qryAux.SQL.Add('  PCD_NUMCTN = 0 ');

      If Not blnTotal Then
       qryAux.SQL.Add('GROUP BY PCMDET.AUTOINCREM ');

      If Not blnTotal Then
       qryAux.SQL.Add('ORDER BY PCD_DESITE ');

      qryAux.ParamByName('NUMPED').AsString  := strNumeroPedido;
      qryAux.ParamByName('ESPDOC').AsString  := strEspecie;
      qryAux.ParamByName('CODEMP').AsString  := strEmpresa;
      qryAux.ParamByName('DECUNI').AsInteger := fCfgSis('DECUNI', varInteger);;

      qryAux.Open;

    End;

begin
  qryAux := fCriaQuery();
  intDecTpc := fCfgSis('DEQTPC', varInteger);

  pCarregaItens(True);


  Try
    pCriarFormularios(TfrmMostraItensPendentes, frmMostraItensPendentes);

    frmMostraItensPendentes.edtTotal.Text := FormatFloat('#,##0.00', qryAux.FieldByName('TOTRES').AsFloat);

    pCarregaItens(False);

    (qryAux.FieldByName('UNILIQ') As TFloatField).DisplayFormat     := fMskDigitos(2);
    (qryAux.FieldByName('TOTRES') As TFloatField).DisplayFormat     := fMskDigitos(2);
    (qryAux.FieldByName('PCD_EMBALA') As TFloatField).DisplayFormat := fMskDigitos(4);

    frmMostraItensPendentes.dtsPedido.DataSet := qryAux;
    frmMostraItensPendentes.ShowModal;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '');
    End;
  End;
  pFreeAndNil(frmMostraItensPendentes);
  qryAux.Close;
  FreeAndNil(qryAux);

end;

procedure TfrmMostraItensPendentes.dbgItensDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
  Var
    fltQtdRes: Double;
    fltQtdBai: Double;
begin
  inherited;

  With dtsPedido.DataSet Do
  Begin
    fltQtdBai := dtsPedido.DataSet.FieldByName('PCD_QTDBAI_NO_FORMAT').AsFloat;
    fltQtdRes := dtsPedido.DataSet.FieldByName('PCD_QTDRES_NO_FORMAT').AsFloat;

    If (fFormataFloat(fltQtdRes, 2) = 0) Then
    Begin
      If dbgItens.Canvas.Brush.Color = clHighLight Then
      Begin
        dbgItens.Canvas.Font.Color := clHighLightText;
      End Else
      Begin
        dbgItens.Canvas.Brush.Color := clMoneyGreen;
      End;
    End

    Else If (fFormataFloat(fltQtdRes, intDecTpc) > 0) And
            (fFormataFloat(fltQtdBai, intDecTpc) > 0) Then
    Begin
      If dbgItens.Canvas.Brush.Color = clHighLight Then
      Begin
        dbgItens.Canvas.Font.Color := clHighLightText;
      End Else
      Begin
        dbgItens.Canvas.Brush.Color := clSkyBlue;
      End;
    End

  End;        

  dbgItens.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

end.
