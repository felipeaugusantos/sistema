unit untCtrMostraDuplicatas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridCitel, DBGrids, strUtils,
  Uni, DB, AppEvnts, BitBtnLockedIncrem, frxClass, frxExportCSVTestabilidade;

type
  TfrmCtrMostraDuplicatas = class(TfrmPai)
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    PopupMenu1: TPopupMenu;
    MenuItem1: TMenuItem;
    dbgDuplicatas: TDBGridCitel;
    btnProdutos: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnProdutosClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    qryTmpCtr: TUniQuery;
    dtsTmpCtr: TDataSource;

  public
    { Public declarations }
    blnSelDocumentosCtrM: Boolean;

    function fMostraDuplicatas(strNumAgr, strCodEmp: String) : Boolean;

  end;

var
  frmCtrMostraDuplicatas: TfrmCtrMostraDuplicatas;

implementation

  uses untfuncoesSimples, untFuncoesRel, untFuncoesRel2, TypesRel;

{$R *.dfm}

procedure TfrmCtrMostraDuplicatas.FormShow(Sender: TObject);
begin
  inherited;

  dbgDuplicatas.Columns[7].Width := 70;

end;

procedure TfrmCtrMostraDuplicatas.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  If (Key = VK_ESCAPE) Then
  Begin
    Close;
  End
  Else If (Key = VK_F7) Then
  Begin
    btnProdutos.Click;
  End

end;

procedure TfrmCtrMostraDuplicatas.btnProdutosClick(Sender: TObject);
  Var
    varRecEst: TRegistroVarFaturamento;
begin
  inherited;

{  Try
    frmRelFatVendasClienteF9 := TfrmRelFatVendasClienteF9.Create(Self);

    With frmRelFatVendasClienteF9 Do
    Begin

      frmRelFatVendasClienteF9.pMostrarProdutos(
       LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_NUMDUP').AsString, 12),
       dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_ESPDOC').AsString,
       LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_CODEMP').AsString, 3));

      ShowModal;
    End;

  Finally
   pFreeAndNil(frmRelFatVendasClienteF9);
  End;
}

  FillChar(varRecEst,SizeOf(varRecEst),#0);
  varRecEst.strCtr_DupPar     := ShortString(LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_DUPPAR').AsString, 6));
  varRecEst.strCtr_EspDoc     := ShortString(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_ESPDOC').AsString);
  varRecEst.strCtr_CodEmp     := ShortString(LeftStr(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_CODEMP').AsString, 3));
  varRecEst.strCodCli         := ShortString(dbgDuplicatas.DataSource.DataSet.FieldByName('CTR_CODCLI').AsString);
  pRelatorioFaturamentoPar(relFatVendasCliente_6,varRecEst);

end;

{*******************************************}
{* MOSTRA AS DUPLICATAS                    *}
{****************************************JB*}
function TfrmCtrMostraDuplicatas.fMostraDuplicatas(strNumAgr, strCodEmp: String) : Boolean;
  Var
    strSQL: String;
    
begin

  strSQL := '';
  strSQL := strSQL + 'SELECT ';
  strSQL := strSQL + '  CTR_NUMDUP, ';
  strSQL := strSQL + '  CTR_PARCEL, ';
  strSQL := strSQL + '  CTR_ESPDOC, ';
  strSQL := strSQL + '  CTR_CODEMP, ';
  strSQL := strSQL + '  CTR_SEQBAI, ';
  strSQL := strSQL + '  CLI_FANSOB, ';
  strSQL := strSQL + '  POR_NOMPOR, ';
  strSQL := strSQL + '  CTR_DTAVEN, ';
  strSQL := strSQL + '  CONCAT(CTR_CODCLI, " - ", CLI_NOMCLI) AS CTR_NOMCLI, ';
  strSQL := strSQL + '  FORMAT(CTR_VALDUP ,2) AS "CTR_VALDUP", ';
  strSQL := strSQL + '  FORMAT(CTR_VALORI ,2) AS "Valor Original", ';
  strSQL := strSQL + '  FORMAT(CTR_VALREC ,2) AS "Valor Recebido", ';
  strSQL := strSQL + '  CTR_DTAREC, ';
  strSQL := strSQL + '  CTR_DTACAD, ';
  strSQL := strSQL + '  CTR_DESCOB, ';
  strSQL := strSQL + '  CTR_NOSNUM, ';
  strSQL := strSQL + '  CTR_HIST01, ';
  strSQL := strSQL + '  CTR_HIST02, ';
  strSQL := strSQL + '  CTR_CODVEL, ';
  strSQL := strSQL + '  CTR_CODVEN, ';
  strSQL := strSQL + '  CTR_OPEBAI, ';
  strSQL := strSQL + '  CADREC.AUTOINCREM AS "AUTOINCREM" ';
  strSQL := strSQL + 'FROM ';
  strSQL := strSQL + '  CADREC ';
  strSQL := strSQL + '  JOIN CADCLI ON CTR_CODCLI = CLI_CODCLI ';
  strSQL := strSQL + '  LEFT JOIN CADPOR ON POR_CODPOR = CTR_CODPOR ';
  strSQL := strSQL + 'WHERE ';
  strSQL := strSQL + '  CTR_NUMDUP = :NUMDUP    AND';
  strSQL := strSQL + '  CTR_CODEMP = :CODEMP';

  With qryTmpCtr Do
  Begin
    Close;
    SQL.Clear;
    SQL.Add(strSQL);
    ParamByName('NUMDUP').AsString := strNumAgr;
    ParamByName('CODEMP').AsString := strCodEmp;
    Open;

    If IsEmpty Then
      Result := False
    Else
      Result := True;

  End;

end;

procedure TfrmCtrMostraDuplicatas.FormCreate(Sender: TObject);
begin
  inherited;

  qryTmpCtr := fCriaQuery(Self);
  dtsTmpCtr := fCriaDataSource(qryTmpCtr);

  dbgDuplicatas.DataSource := dtsTmpCtr;

  blnSelDocumentosCtrM := FALSE;
end;

end.

