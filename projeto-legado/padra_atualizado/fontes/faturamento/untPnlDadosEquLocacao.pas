unit untPnlDadosEquLocacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, DBCtrls, DBMemoFocus, Mask, DBEditFocus, Buttons,
  EditFocus, UniClientDataSet, DB,   Uni,
  ActnList, cxStyles, cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage,
  cxEdit, cxDBData, cxColorComboBox, cxGridLevel, cxGridCustomTableView,
  cxGridTableView, cxGridBandedTableView, cxGridDBBandedTableView, cxClasses,
  cxControls, cxGridCustomView, cxGrid, BitBtnLockedIncrem,
  cxLookAndFeels, cxLookAndFeelPainters, cxNavigator, untTypesSistema,
  untClassPanelCx, cxGridDBTableView, cxGridCitel,
  untGerenciaPropriedadesComponentes, cxProgressBar, Vcl.Menus, cxContainer, cxLabel,
  cxDataControllerConditionalFormattingRulesManagerDialog, Vcl.ComCtrls,
  cxInplaceContainer, cxVGrid, cxCurrencyEdit, cxTextEdit, cxButtonEdit,
  Datasnap.DBClient, DBAccess, cadastro.Model.EquipamentoLocacao, cxSplitter;

type
  TfrmPnlDadosEquLocacao = class(TForm)
    cxGridNegociacaoDiarias: TcxGridCitel;
    cxGridDBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridDBTableViewCitel1QTDDIA: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRTOT: TcxGridDBColumn;
    cxGridDBTableViewCitel1VLRDIA: TcxGridDBColumn;
    cxGridLevel1: TcxGridLevel;
    dtsNegociacaoDiarias: TUniDataSource;
    cdsNegociacaoDiarias: TUniClientDataSet;
    cdsNegociacaoDiariasQTDDIA: TIntegerField;
    cdsNegociacaoDiariasVLRTOT: TFloatField;
    cdsNegociacaoDiariasVLRDIA: TFloatField;
    cxSplitter1: TcxSplitter;
    cxGridContratoEqu: TcxGridCitel;
    cxGridDBTableViewCitel2: TcxGridDBTableViewCitel;
    cxGridDBTableViewCitelEQL_NROCON: TcxGridDBColumn;
    cxGridDBTableViewCitelEQL_DTAINI: TcxGridDBColumn;
    cxGridDBTableViewCitelEQL_HORINI: TcxGridDBColumn;
    cxGridDBTableViewCitelEQL_DTAFIN: TcxGridDBColumn;
    cxGridDBTableViewCitelEQL_HORFIN: TcxGridDBColumn;
    cxGridLevel2: TcxGridLevel;
    dtsContratoEqu: TUniDataSource;
    cdsContratoEqu: TUniClientDataSet;
    cdsContratoEquEQL_NROCON: TStringField;
    cdsContratoEquEQL_DTAINI: TDateField;
    cdsContratoEquEQL_HORINI: TTimeField;
    cdsContratoEquEQL_DTAFIN: TDateTimeField;
    cdsContratoEquEQL_HORFIN: TDateTimeField;
    cdsContratoEquEQL_STATUS: TStringField;
    cxGridDBTableViewCitelEQL_STATUS: TcxGridDBColumn;
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    objEquLoc: TEquipamentoLocacaoPrincipal;
    FblnPodeCarregarDados: Boolean;

    procedure pConsultaAfterScroll(DataSet: TDataSet);
    procedure pCarregarContratosPorEquipamento;
    procedure pCarregarNegociacaoDiarias;
    procedure pFormatarCamporContratoPorEquipamento;
  public
    { Public declarations }
    strNomForm: String;
    btnConfirma: TBitBtnLocked;
    objPanel: TPanelCx;
    cdsConsulta: TUniClientDataSet;

    constructor Create(AOwner: TComponent); reintroduce; virtual;

    procedure pIniciouNavegacaoGridConsulta;
    procedure pParouNavegacaoGridConsulta;
    procedure pAtualizarAplicacao; virtual; abstract;
    procedure pAdicionarNegociacaoDiariaGrid(const aItem: TNegociacaoDiaria);
  end;

  TfrmPnlDadosEquLocacaoClass = Class Of TfrmPnlDadosEquLocacao;

implementation

uses
  MaskUtils, untFuncoesSimples, untFuncoesGenerica, untResFinanceiro;

{$R *.dfm}

{ TfrmPnlDadosEquLocacao }

constructor TfrmPnlDadosEquLocacao.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  cdsNegociacaoDiarias.CreateDataSet;
  cdsContratoEqu.CreateDataSet;
  objEquLoc := TEquipamentoLocacaoPrincipal.Create;
  pFormatarCamporContratoPorEquipamento;
  FblnPodeCarregarDados := False;
end;

procedure TfrmPnlDadosEquLocacao.FormDestroy(Sender: TObject);
begin
  FreeAndNil(objEquLoc);
end;

procedure TfrmPnlDadosEquLocacao.FormShow(Sender: TObject);
begin
  cdsConsulta.AfterScroll := pConsultaAfterScroll;
end;

procedure TfrmPnlDadosEquLocacao.pAdicionarNegociacaoDiariaGrid(
  const aItem: TNegociacaoDiaria);
begin
  Try
    cdsNegociacaoDiarias.Insert;
    cdsNegociacaoDiarias.FieldByName('QTDDIA').AsInteger := aItem.QuantidadeDias;
    cdsNegociacaoDiarias.FieldByName('VLRTOT').AsFloat   := aItem.ValorTotal;
    cdsNegociacaoDiarias.FieldByName('VLRDIA').AsFloat   := aItem.ValorDiaria;
    cdsNegociacaoDiarias.Post;
  Except
    On E: Exception Do
    Begin
      pMensagensErro(E.Message,'[TfrmCadEquLocacao.pAdicionarNegociacaoDiariaGrid]');
    End;
  End;
end;

procedure TfrmPnlDadosEquLocacao.pCarregarNegociacaoDiarias;
var
  intCnt: Integer;
begin
  If cdsNegociacaoDiarias.Active Then
    cdsNegociacaoDiarias.EmptyDataSet;

  If (Not FblnPodeCarregarDados)  Then
    Exit;

  cdsNegociacaoDiarias.DisableControls;
  Try
    objEquLoc.Codigo := cdsConsulta.FieldByName('EQL_CODIGO').AsString;
    objEquLoc.pCarregaConsultaNegociacaoDiarias(cdsConsulta.FieldByName('AUTOINCREM').AsString);
    For intCnt := 0 to objEquLoc.Diarias.Count-1 Do
    Begin
      pAdicionarNegociacaoDiariaGrid(objEquLoc.Diarias[intCnt]);
    End;
  Finally
    cdsNegociacaoDiarias.EnableControls;
  End;
end;

procedure TfrmPnlDadosEquLocacao.pConsultaAfterScroll(
  DataSet: TDataSet);
begin
  pCarregarNegociacaoDiarias;
  pCarregarContratosPorEquipamento;
  FblnPodeCarregarDados := False;
end;

procedure TfrmPnlDadosEquLocacao.pFormatarCamporContratoPorEquipamento;
begin
  TDateField(cdsContratoEqu.FieldByName('EQL_DTAINI')).EditMask  := '99/99/9999';
  TDateField(cdsContratoEqu.FieldByName('EQL_DTAFIN')).EditMask  := '99/99/9999';
  TTimeField(cdsContratoEqu.FieldByName('EQL_HORINI')).DisplayFormat := 'hh:nn';
  TTimeField(cdsContratoEqu.FieldByName('EQL_HORFIN')).DisplayFormat := 'hh:nn';
end;

procedure TfrmPnlDadosEquLocacao.pIniciouNavegacaoGridConsulta;
begin
  inherited;


  FblnPodeCarregarDados := True;
end;

procedure TfrmPnlDadosEquLocacao.pParouNavegacaoGridConsulta;
begin
  inherited;

  FblnPodeCarregarDados := True;
end;

procedure TfrmPnlDadosEquLocacao.pCarregarContratosPorEquipamento;
var
  qry: TUniQuery;
begin
  If cdsContratoEqu.Active Then
    cdsContratoEqu.EmptyDataSet;

  If (Not FblnPodeCarregarDados) Then
    Exit;

  qry := fCriaQuery;
  Try
    cdsContratoEqu.DisableControls;
    qry.DisableControls;
    Try
      qry.SQL.Add('SELECT DISTINCT EQL_NROCON, ');
      qry.SQL.Add('                EQL_DTAINI, ');
      qry.SQL.Add('                EQL_HORINI, ');
      qry.SQL.Add('                EQL_DTAFIN, ');
      qry.SQL.Add('                EQL_HORFIN, ');
      qry.SQL.Add('                (CASE WHEN EQL_STATUS = "O" THEN "ORÇAMENTO"                ');
      qry.SQL.Add('                      WHEN EQL_STATUS = "A" THEN "ATIVO" END) AS EQL_STATUS ');
      qry.SQL.Add(' FROM CONEQL                ');
      qry.SQL.Add(' INNER JOIN EQLDET ON EQD_SEQCON = CONEQL.AUTOINCREM  ');
      qry.SQL.Add(' WHERE EQD_SEQEQL = :EQD_SEQEQL');
      qry.SQL.Add('   AND EQL_CODEMP = :EQD_CODEMP');
      qry.SQL.Add('   AND ((EQL_STATUS = "O")  ');
      qry.SQL.Add('   OR   (EQL_STATUS = "A")) ');
      qry.SQL.Add('  ORDER BY EQL_NROCON       ');

      qry.ParamByName('EQD_SEQEQL').AsString := cdsConsulta.FieldByName('EQL_CODIGO').AsString;
      qry.ParamByName('EQD_CODEMP').AsString := VS_strCodEmp;
      qry.Open;
      While Not (qry.Eof) Do
      Begin
        cdsContratoEqu.Insert;
        cdsContratoEqu.FieldByName('EQL_NROCON').AsString   := qry.FieldByName('EQL_NROCON').AsString;
        cdsContratoEqu.FieldByName('EQL_DTAINI').AsDateTime := qry.FieldByName('EQL_DTAINI').AsDateTime;
        cdsContratoEqu.FieldByName('EQL_HORINI').AsDateTime := qry.FieldByName('EQL_HORINI').AsDateTime;
        cdsContratoEqu.FieldByName('EQL_DTAFIN').AsDateTime := qry.FieldByName('EQL_DTAFIN').AsDateTime;
        cdsContratoEqu.FieldByName('EQL_HORFIN').AsDateTime := qry.FieldByName('EQL_HORFIN').AsDateTime;
        cdsContratoEqu.FieldByName('EQL_STATUS').AsString   := qry.FieldByName('EQL_STATUS').AsString;
        cdsContratoEqu.Post;

        qry.Next;
      End;
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmContratosAbertosPorEqlLoc.pConsultaAfterScroll]');
      End;
    End;
  Finally
    pFreeAndNil(qry);
    cdsContratoEqu.EnableControls;
  End;
end;

end.
