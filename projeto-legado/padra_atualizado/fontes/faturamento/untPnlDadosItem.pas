{***************************************************************}
{* TELA DO PAINEL CRIADA PARA NOVA FUNÇÃO DE CONSULTA DE ITENS *}
{************************************************************JU*}
unit untPnlDadosItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DBMemoFocus, Mask, DBEditFocus, Buttons,
  EditFocus, UniClientDataSet, DB,   Uni,
  ActnList, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxColorComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untTypesSistema, untFuncoesSimples,
  untClassPanelCx, cxGridDBTableView, cxGridCitel,
  untGerenciaPropriedadesComponentes, cxProgressBar, Vcl.Menus, cxContainer, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  cxInplaceContainer, cxVGrid, cxCurrencyEdit, cxTextEdit, cxButtonEdit;

type
  TfrmPnlDadosItem = class(TForm)
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }

    blnEstaNoPainel: Boolean;

    intPraMedio: Integer;
    strTabPre  : String;
    strNomForm : String;
    strCodVen  : String;
    strCodDig  : String;
    strCodCli  : String;
    strEmprCD  : String;
    strCodCnd : String;
    cdsConsulta: TUniClientDataSet;
    cdsSubConsulta : TUniClientDataSet;
    blnFaturamento: Boolean;
    blnPedCorte  : Boolean;
    blnExibirVrUnitarioPedCompraGrid: Boolean;
    strOpcDoc: String;
    strSenVen: String;
    procVendasPerdidas: TProcVendasGenerica;
    procMostraDocumentoReimpressao: TMostraDocumentoReimpressao;
    procRelVendasPerdidas: TProcRelVendasGenerica;
    procExibeAgregados : TProcExibeAgregados;
    procExibeRequisicaoCompra : TProcExibeRequisicaoCompra;
    procExibeCndPag : TProcExibeCndPag;

    strEmpIte,
    strEmpSal: String;
    blnExiSalDisCD: Boolean;

    btnConfirma: TBitBtnLocked;

    objPanel: TPanelCx;

    strNumOrc  : String;
    strEspOrc  : String;

    blnCndPag    : Boolean;
    strCodCndPag : String;
    strCndPag    : String;
    strCodForPag : String;
    strDesForPag : String;
    fltDescMaxV  : Double;
    fltDescMaxG  : Double;
    fltDescApli  : Double;
    fltTxJuros   : Double;
    blnConfirmaCndPag : Boolean;

    procedure pResetatmrAtualizarDados; virtual; abstract;

    procedure pSetPnlDadosItemVisible(AVisible: Boolean); virtual; abstract;

    procedure pAtualizarAplicacao; virtual; abstract;

    procedure pIniciouNavegacaoGridConsulta; virtual; abstract;
    procedure pParouNavegacaoGridConsulta; virtual; abstract;

    procedure pOnDisplayText(Sender: TcxCustomGridTableItem;
                              ARecord: TcxCustomGridRecord;
                              var AText: string); virtual; abstract;

    function fGetSQLPromocaoBrindes: string;
    procedure pAbrePromocaoBrindes(strCodIte : String; MemProBrin : TMemo);
    procedure pAtualizaInformacaoSubConsulta; virtual; abstract;
  end;

  TfrmPnlDadosItemClass = Class Of TfrmPnlDadosItem;

var
  frmPnlDadosItem: TfrmPnlDadosItem;

implementation

uses  cxGridUIHelper,
      StrUtils;

{$R *.dfm}

procedure TfrmPnlDadosItem.FormDestroy(Sender: TObject);
begin
  Inherited;
  {}
end;

procedure TfrmPnlDadosItem.pAbrePromocaoBrindes(strCodIte : String; MemProBrin : TMemo);
Var
  qrySQL: TUniQuery;
Begin
  Try
    qrySQL := fCriaQuery(Nil);
    qrySQL.SQL.Text := fGetSQLPromocaoBrindes;
    qrySQL.ParamByName('CODITE').AsString := strCodIte;
    qrySQL.ParamByName('CODEMP').AsString := VS_strCodEmp;
    qrySQL.Open;

    MemProBrin.Visible := (not qrySQL.IsEmpty);
    MemProBrin.Lines.Text := AnsiReplaceStr(qrySQL.FieldByName('MENSAGEM').asString, '<<csq>>', #13#10);
  Finally
    FreeAndNil(qrySQL);
  End;
End;

function TfrmPnlDadosItem.fGetSQLPromocaoBrindes: string;
Begin
  Result := Result + ' SELECT CONCAT("*",PROBRI_GER.PRO_DESPRO,"*"," - ","Na compra de (10 ",U.UNI_SIGUNI,") desse produto, o cliente acumulará ",(10*PRO_QTDPON)," pontos e atingindo ",';
  Result := Result + '               PRO_PONACU," pontos, ganhará como brinde o produto: ", IB.ITE_CODITE," - ", IB.ITE_DESITE,';
  Result := Result + '               " - (",B.PRO_QTDBRI," ",UB.UNI_SIGUNI,")","<<csq>>",';
  Result := Result + '               "Validade da Promoção: ",DATE_FORMAT(PRO_DTAINI, "%d/%m/%Y"), " a ", DATE_FORMAT(PRO_DTAFIN, "%d/%m/%Y") ) AS MENSAGEM';
  Result := Result + ' FROM PROBRI_GER ';
  Result := Result + '   INNER JOIN PROBRI_ITE   ON PRO_SEQGER    = PROBRI_GER.AUTOINCREM';
  Result := Result + '   INNER JOIN CADITE       ON ITE_CODITE    = PRO_CODITE';
  Result := Result + '   INNER JOIN CADUNI     U ON U.UNI_CODUNI  = ITE_CODUNI';
  Result := Result + '   INNER JOIN PROBRI_BRI B ON B.PRO_SEQGER  = PROBRI_GER.AUTOINCREM';
  Result := Result + '   INNER JOIN CADITE IB    ON IB.ITE_CODITE = B.PRO_CODBRI';
  Result := Result + '   INNER JOIN CADUNI UB    ON UB.UNI_CODUNI = IB.ITE_CODUNI';
  Result := Result + '   INNER JOIN PROBRI_EMP E ON PROBRI_GER.AUTOINCREM = E.PRO_SEQGER';
  Result := Result + ' WHERE ';
  Result := Result + '   CURRENT_DATE BETWEEN PRO_DTAINI AND PRO_DTAFIN AND';
  Result := Result + '   PRO_CODITE   = :CODITE AND';
  Result := Result + '   E.PRO_CODEMP = :CODEMP ';
End;

end.

