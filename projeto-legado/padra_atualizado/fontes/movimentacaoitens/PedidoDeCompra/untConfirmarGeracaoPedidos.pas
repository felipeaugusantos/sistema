unit untConfirmarGeracaoPedidos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB,
  cxDBData, cxGridLevel, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid, Vcl.StdCtrls,
  frxClass, frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus,
  Vcl.Buttons, BitBtnLockedIncrem, Vcl.ExtCtrls, Vcl.ComCtrls, untZClient, Uni;

type
  TfrmConfirmarGeracaoPedidos = class(TfrmPai)
    Panel2: TPanel;
    pnlCabecalho: TPanel;
    Label1: TLabel;
    cxgProdutos: TcxGrid;
    cxvEstoque: TcxGridDBTableView;
    cxgProdutosCODIGO: TcxGridDBColumn;
    cxgProdutosDESITE: TcxGridDBColumn;
    cxgProdutosSALDOS: TcxGridDBColumn;
    cxgProdutosLevel1: TcxGridLevel;
    btnConfirmar: TBitBtnLocked;
    btnGerarExcel: TBitBtnLocked;
    prgProgresso: TProgressBar;
    SaveDialog: TSaveDialog;
    procedure btnGerarExcelClick(Sender: TObject);
    Procedure pGeraExcel;
    procedure FormCreate(Sender: TObject);
    procedure btnConfirmarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
 protected
    dtsAux: TDataSource;
    qryConsulta: TZClient;

    //qryConsulta: TUniQuery;
    procedure pCarregaDados(strItens: String);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirmacao : Boolean;
    class function fPedeConfirmacaoGeracaoPedido(strItens: String): Boolean;
  end;

var
  frmConfirmarGeracaoPedidos: TfrmConfirmarGeracaoPedidos;

implementation

{$R *.dfm}

Uses
  untGeraExcel, untFuncoesSimples;

procedure TfrmConfirmarGeracaoPedidos.btnGerarExcelClick(Sender: TObject);
begin
  inherited;
  If fPergunta('Confirma a geração do Excel?') Then
    pGeraExcel;
end;

procedure TfrmConfirmarGeracaoPedidos.pCarregaDados(strItens: String);
Var
    strSQL     : String;
begin

  strSQL := '';
  strSQL := strSQL + '  SELECT I.ITE_CODITE AS CODIGO, ';
  strSQL := strSQL + '         I.ITE_DESITE AS DESITE, ';
  strSQL := strSQL + '         SUM(' + fSQLSaldoDisponivel('G', True, False, True) + ') AS SALDOS ';
  strSQL := strSQL + '    FROM CADITE I ';
  strSQL := strSQL + '   INNER JOIN ITEGER G ON G.ITE_CODITE = I.ITE_CODITE ';
  strSQL := strSQL + '   INNER JOIN EMPPAR ON PAR_CODEMP   = G.ITE_CODEMP ';
  strSQL := strSQL + '   WHERE I.ITE_CODITE = G.ITE_CODITE ';
  strSQL := strSQL + '    AND I.ITE_CODITE in (' + strItens + ') ';
  strSQL := strSQL + '    AND PAR_TIPEMP = 2 ';
  strSQL := strSQL + '  GROUP BY I.ITE_CODITE ';
  strSQL := strSQL + ' HAVING SALDOS > 0 ';

  qryConsulta.Close;

  qryConsulta.qryQuery.SQL.Clear;
  qryConsulta.qryQuery.SQL.Add(strSQL);

  Try
    //qryConsulta.Open;
    dtsAux := qryConsulta.dtsSource;
    qryConsulta.fAbreClient;
    (qryConsulta.FieldByName('SALDOS') As TFloatField).DisplayFormat := '#,##0.00';
    qryConsulta.First;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message, '[frmConfirmarGeracaoPedidos.pCarregaDados]');
    End;
  End;
end;

procedure TfrmConfirmarGeracaoPedidos.btnConfirmarClick(Sender: TObject);
begin
  inherited;
  blnConfirmacao := True;
  //FreeAndNil(frmConfirmarGeracaoPedidos);
end;

procedure TfrmConfirmarGeracaoPedidos.FormCreate(Sender: TObject);
begin
  inherited;
  blnConfirmacao := False;
  qryConsulta := TZClient.Create(Self);//fCriaQuery;
end;

procedure TfrmConfirmarGeracaoPedidos.FormDestroy(Sender: TObject);
begin
  FreeAndNil(qryConsulta);
  inherited;
end;

procedure TfrmConfirmarGeracaoPedidos.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;
  Case Key of
    VK_f9:  btnGerarExcel.Click;
    VK_f10: btnConfirmar.Click;
  End;
end;

class function TfrmConfirmarGeracaoPedidos.fPedeConfirmacaoGeracaoPedido(
  strItens: String): Boolean;
begin
  Result := true;

  If Not fCfgSis('CONCMS', varBoolean) Then
    Exit;

  pCriarFormularios(TfrmConfirmarGeracaoPedidos, frmConfirmarGeracaoPedidos);
  Try
    frmConfirmarGeracaoPedidos.pCarregaDados(strItens);
    If frmConfirmarGeracaoPedidos.qryConsulta.IsEmpty Then
      Exit;

    frmConfirmarGeracaoPedidos.cxvEstoque.DataController.DataSource := frmConfirmarGeracaoPedidos.dtsAux; //frmConfirmarGeracaoPedidos.qryConsulta.DataSource;
    frmConfirmarGeracaoPedidos.Showmodal;
    Result := frmConfirmarGeracaoPedidos.blnConfirmacao;
  Finally
    FreeAndNil(frmConfirmarGeracaoPedidos);
  End;
end;

procedure TfrmConfirmarGeracaoPedidos.pGeraExcel;
  Var
    objGeraExcel: TGeraExcel;
    intIndice: Integer;
    strNomExc: String;

    dtsAux: TDataset;
Begin

  If not SaveDialog.Execute Then
    Exit;

  dtsAux := cxvEstoque.DataController.DataSource.DataSet;
  With dtsAux Do
  Begin

    Try
      dtsAux.DisableControls;

      prgProgresso.Visible  := True;

      First;

      strNomExc := SaveDialog.FileName; // ExtractFilePath(Application.ExeName) + FormatDateTime('YYYYMMDD', VS_Date);

      If FileExists(strNomExc) Then
        If Not DeleteFile(strNomExc) Then
        Begin
          fMensagem('','Não é possível gerar o arquivo, ' +
                       'verifique se o mesmo está sendo utilizado!', ['&Ok']);
          Exit;
        End;

      objGeraExcel := TGeraExcel.Create(dtsAux, prgProgresso);

      With objGeraExcel Do
      Begin
        strNomArq := strNomExc;

        strNomRel := 'SALDO DISPONIVEL DE PRODUTOS EM OUTRAS LOJAS';

        For intIndice := 0 To cxvEstoque.ColumnCount - 1 Do
          objGeraExcel.AddCampo(cxvEstoque.Columns[intIndice].DataBinding.FieldName,
                                cxvEstoque.Columns[intIndice].Caption);

        If fGerarRelatorio Then
          pMensagemOk('Arquivo gerado com sucesso em ' + strNomExc + '!');
      End;

    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, 'TfrmConfirmarGeracaoPedidos.pGeraExcel');
        If Not VarIsEmpty(objGeraExcel.objExcel.Excel) Then
          objGeraExcel.objExcel.FecharArquivo;
      End;
    End;

    FreeAndNil(objGeraExcel);
    prgProgresso.Visible := False;
    EnableControls;
  End;

End;

end.
