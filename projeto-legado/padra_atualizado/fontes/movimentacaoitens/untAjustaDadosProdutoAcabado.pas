unit untAjustaDadosProdutoAcabado;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPaiConfirma, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.Buttons, Vcl.StdCtrls,
  BitBtnLockedIncrem, Vcl.ExtCtrls, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxLabel, cxCurrencyEdit, cxButtonEdit, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  System.Actions, Vcl.ActnList, untCadLoteItens, uni, untFuncoesSimples, untOrdProIndustrial,
  untTypesSistema, EditFocus, untConsultas;

type
  TfrmAjustaDadosProdutoAcabado = class(TfrmPaiConfirma)
    ActionList1: TActionList;
    LoteRapido: TAction;
    PesqLotes: TAction;
    cxgItens: TcxGrid;
    cxgItensView: TcxGridDBTableView;
    cxgItensORDITE: TcxGridDBColumn;
    cxgItensDESITE: TcxGridDBColumn;
    cxgItensSIGUNI: TcxGridDBColumn;
    cxgItensQTDPRO: TcxGridDBColumn;
    cxgItensViewColumn4: TcxGridDBColumn;
    cxgItensPESUNI: TcxGridDBColumn;
    cxgItensQTDENV: TcxGridDBColumn;
    cxgItensNUMLOT: TcxGridDBColumn;
    cxgItensLevel1: TcxGridLevel;
    procedure LoteRapidoExecute(Sender: TObject);
    procedure PesqLotesExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    FOrdPro: TOrdProIndustrial;

    { Private declarations }
  public
    { Public declarations }

    property objOrdPro: TOrdProIndustrial read FOrdPro write FOrdPro;

  end;

var
  frmAjustaDadosProdutoAcabado: TfrmAjustaDadosProdutoAcabado;

implementation

{$R *.dfm}

procedure TfrmAjustaDadosProdutoAcabado.FormShow(Sender: TObject);
begin
  inherited;

  //Inclui 4 digitos caso o parametro DECQTD = 4
  if fCfgSis('DECQTD', varString) = 4 then
  begin
    TcxCurrencyEditProperties(cxgItensQTDENV.Properties).DecimalPlaces := 4;
    TcxCurrencyEditProperties(cxgItensQTDENV.Properties).DisplayFormat := '0.0000';
  end;
end;

procedure TfrmAjustaDadosProdutoAcabado.LoteRapidoExecute(Sender: TObject);
  Var
    frmCadLoteItens: TfrmCadLoteItens;
    qryGen: TUniQuery;
    strLotCad : String;
    intMesVal : Integer;
begin
  If Not fVerificaAcessoSistema('frmCadLoteItensRapido') Then
  Begin
    fMensagem('', 'Operador não tem direito de acesso ao cadastro de Lotes!', ['&O k']);
    Exit;
  End;

  Try
    intMesVal := fCampoTabela('ITE_PRAVAL', 'CADITE', ['ITE_CODITE'], [FOrdPro.FieldByName('ORD_CODITE').AsString]);

    pCriarFormularios(TfrmCadLoteItens, frmCadLoteItens);
    frmCadLoteItens.strCodigoItemCadastroRapidoWMS   := FOrdPro.FieldByName('ORD_CODITE').AsString;
    frmCadLoteItens.strDataValidadeCadastroRapidoWMS := DateToStr(IncMonth(VS_Date, intMesVal));
    frmCadLoteItens.blnBaixaOPI:= True;

    frmCadLoteItens.tipoCadastro := tclOrdemProducaoIndustrial;
    frmCadLoteItens.ShowModal;
    strLotCad := frmCadLoteItens.strNumeroLoteCadastroRapidoWMS;

    If (fCfgSis('LOTEND', varString) = '2') And fUsaRotinaWMS Then
    Begin
      qryGen:= fCriaQuery();
      Try
        qryGen.SQL.Add(' UPDATE CADLOT SET LOT_CODBAR = :NUMLOT ');
        qryGen.SQL.Add('   WHERE LOT_CODEMP = :CODEMP AND       ');
        qryGen.SQL.Add('         LOT_CODITE = :CODITE AND       ');
        qryGen.SQL.Add('         LOT_NUMLOT = :NUMLOT           ');

        qryGen.ParamByName('CODEMP').AsString:= VS_strCodEmp;
        qryGen.ParamByName('NUMLOT').AsString:= strLotCad;
        qryGen.ParamByName('CODITE').AsString:= FOrdPro.FieldByName('ORD_CODITE').AsString;
        qryGen.ExecSQL;
      Finally
        FreeAndNil(qryGen);
      End;
    End;

    If Not fEmptyStr(strLotCad) Then
    Begin
      FOrdPro.Edit;
      FOrdPro.FieldByName('NUMLOT').AsString := strLotCad;
      FOrdPro.Post;
    End;

  Except
    On E: Exception Do
      pMensagensErro(E.Message, '');
  End;

  pFreeAndNil(frmCadLoteItens);

end;


procedure TfrmAjustaDadosProdutoAcabado.PesqLotesExecute(Sender: TObject);
  Var
    chrKey   : Char;
    arrLotes : TConsultasArray;
    qryConsu : TUniQuery;
    edtCodite: TEditFocus;
Begin
  qryConsu := fCriaQuery(Self);
  edtCodite:= TEditFocus.Create(Self);

  chrKey := '/';

  edtCodite.Text := objOrdPro.FieldByName('ORD_CODITE').AsString;

  If fPesqLoteItens(Self, Nil, edtCodite, fCfgSis('DECUNI', varInteger), qryConsu, chrKey, arrLotes, True, FOrdPro.FieldByName('ORD_CODITE').AsString, VS_strCodEmp, True, False, nil, False, False) Then
  Begin
    FOrdPro.Edit;
    FOrdPro.FieldByName('NUMLOT').AsString := qryConsu.FieldByName('LOT_NUMLOT').AsString;
    FOrdPro.Post;
  End;

  FreeAndNil(qryConsu);
End;

end.
