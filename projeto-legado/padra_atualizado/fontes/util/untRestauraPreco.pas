unit untRestauraPreco;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, untPai, Vcl.ExtCtrls, frxClass,
  frxExportCSVTestabilidade, Vcl.AppEvnts, Vcl.Menus, Vcl.StdCtrls, Vcl.Buttons,
  BitBtnLockedIncrem, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter, cxData,
  cxDataStorage, cxEdit, cxNavigator,
  cxDataControllerConditionalFormattingRulesManagerDialog, Data.DB, cxDBData,
  cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridCitel, cxGrid, untZClient, untConstantes, untFuncoesSimples, untRestauraPrecoDetalhes,
  cxContainer, cxProgressBar, MemDS, DBAccess, Uni, strUtils, untPreAlt_Trigger;

type
  TfrmRestauraPreco = class(TfrmPai)
    cxGridCitel1DBTableViewCitel1: TcxGridDBTableViewCitel;
    cxGridCitel1Level1: TcxGridLevel;
    cxGridCitel1: TcxGridCitel;
    dtsDados: TDataSource;
    cxGridCitel1DBTableViewCitel1Column1: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column2: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column3: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column4: TcxGridDBColumn;
    cxGridCitel1DBTableViewCitel1Column5: TcxGridDBColumn;
    btnMarTod: TBitBtnLocked;
    btnRestaura: TBitBtnLocked;
    UniQuery1: TUniQuery;
    procedure FormCreate(Sender: TObject);
    procedure btnMarTodClick(Sender: TObject);
    procedure btnRestauraClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);

  private
    cdsDados: TZClient;
    cdsItens: TZClient;
    blnPreMat: Boolean;
    intInfFed,
    intInfOpe,
    intInfSai: Integer;
    blnInfMat: Boolean;

    strAgrupadorPreAlt: String;


    procedure pAbreDetalhes;
    function fConfirmaItensAux(pgbProgresso: TcxProgressBar): Boolean;
    function fGravaPrecos(pgbProgresso: TcxProgressBar; blnResFor: Boolean): Boolean;
    procedure pSQLCamposCusto(var strUPD: String; blnResFor: Boolean);
    procedure pSetBindCamposCusto(blnResFor: Boolean; qryUpdate: TUniQuery);
    procedure pAjustaDemaisItens(blnResFor: Boolean; strEmpresas: string);
    function isTrue(blnCondicional: Boolean): Boolean;



    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRestauraPreco: TfrmRestauraPreco;

implementation

uses
  untGravando, untPreAlt, untFuncoesAuxiliares;


{$R *.dfm}

procedure TfrmRestauraPreco.btnRestauraClick(Sender: TObject);
  var
    strDataHora: String;
begin
  inherited;
  If blnPreMat Then
  Begin
    fMensagem('', 'Alteração permitida somente na Loja Matriz!', ['&Ok']);
    Exit;
  End;
  strDataHora := cdsDados.FieldByName('ALT_DTAALT').AsString + ' ' + cdsDados.FieldByName('ALT_HORALT').AsString;

  If fPergunta('Confirma a Restauração dos Preços Alterados em ' + strDataHora + ' pelo processo ' +
                cdsDados.FieldByName('LOCALT').AsString + '?') Then
  Begin
    strAgrupadorPreAlt := '';
    pPreAltDefineVariaveisAltPre(fNow,'RESTAURAÇÃO DE PREÇO - ' + strDataHora, strLoginUsuarioLogado, VS_StrCodEmp, strAgrupadorPreAlt);

    pAbreDetalhes;

    Try
      pCriarFormularios(TfrmGravando, frmGravando);
      frmGravando.fExecutarAcao := fConfirmaItensAux;
      frmGravando.lblGravando.Caption := 'Aguarde, atualizando itens...';
      frmGravando.ShowModal;

      pMensagemOk('Preços Restaurados com Sucesso!');
    Except
      On E: Exception Do
      Begin
        pMensagensErro(E.Message, '[TfrmRestauraPreco.btnRestauraClick]');
      End;
    End;

    FreeAndNil(frmGravando);

    strAgrupadorPreAlt := '';


  End;

end;

function TfrmRestauraPreco.fConfirmaItensAux(
  pgbProgresso: TcxProgressBar): Boolean;
begin
    Result := fGravaPrecos(pgbProgresso, False);

    If fCfgSis('INFMAT', varBoolean) Then
      Result := Result And fGravaPrecos(pgbProgresso, True);
end;


function TfrmRestauraPreco.fGravaPrecos(pgbProgresso: TcxProgressBar; blnResFor: Boolean): Boolean;
  Var
    strUPD: String;
    strEmpresas: String;
    qryUpdate : TUniQuery;
begin
  strEmpresas := fRetEmpresasUsamPrecoMatriz;
  Result := True;

  qryUpdate := fCriaQuery(Self);

  strUPD := '';
  strUPD := strUPD + 'UPDATE ';
  strUPD := strUPD + '  ITEGER ';
  strUPD := strUPD + 'SET ';

  strUPD := strUPD + '  ITE_PREDOL = :DOLANT,';
  strUPD := strUPD + '  ITE_PRECOM = :COMANT,';
  strUPD := strUPD + '  ITE_IPIENT = :IPIANT,';
  strUPD := strUPD + '  ITE_FREENT = :FREANT,';
  strUPD := strUPD + '  ITE_VALFRE = :VFRANT,';
  strUPD := strUPD + '  ITE_PRECUS = :CUSANT,';

  strUPD := strUPD + '  ITE_DESF01 = :DF1ANT,';
  strUPD := strUPD + '  ITE_DESF02 = :DF2ANT,';
  strUPD := strUPD + '  ITE_DESF03 = :DF3ANT,';
  strUPD := strUPD + '  ITE_DESF04 = :DF4ANT,';
  strUPD := strUPD + '  ITE_DESF05 = :DF5ANT,';
  strUPD := strUPD + '  ITE_DESF06 = :DF6ANT,';

  strUPD := strUPD + '  ITE_TCIFCU = :TCIANT,';
  strUPD := strUPD + '  ITE_TSCUST = :TSCANT,';
  strUPD := strUPD + '  ITE_DEPICO = :DEPANT,';
  strUPD := strUPD + '  ITE_DEICMS = :DEIANT,';
  strUPD := strUPD + '  ITE_FATREG = :FATANT,';

  strUPD := strUPD + '  ITE_ACRFIN = :AFNANT,';
  strUPD := strUPD + '  ITE_ICMENT = :ICEANT,';
  strUPD := strUPD + '  ITE_SUBFED = :SFDANT,';
  strUPD := strUPD + '  ITE_SUBSTI = :STIANT,';
  strUPD := strUPD + '  ITE_PREALT = :PREALT,';

  strUPD := strUPD + '  ITE_DESADB = :DABANT';

  pSQLCamposCusto(strUPD, blnResFor);

  strUPD := strUPD + 'WHERE ';
  strUPD := strUPD + '  ITE_CODITE = :CODITE AND ';

  If blnResFor Then
    strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) = 0 '
  Else
    strUPD := strUPD + '  LOCATE(ITE_CODEMP, :CODEMP) > 0 ';
  pgbProgresso.Properties.Max := cdsItens.RecordCount;
  while not cdsItens.Eof do
  Begin
    pgbProgresso.Position := cdsItens.RecNo;
    Application.ProcessMessages;
    qryUpdate.Close;
    qryUpdate.SQL.Clear;
    qryUpdate.SQL.Add(strUPD);


    qryUpdate.ParamByName('DOLANT').AsString  :=  cdsItens.FieldByName('ITE_PREDOL_ANT').AsString;
    qryUpdate.ParamByName('PREALT').AsString  :=  strAgrupadorPreAlt;
    qryUpdate.ParamByName('COMANT').AsFloat   :=  cdsItens.FieldByName('ITE_PRECOM_ANT').AsFloat;
    qryUpdate.ParamByName('IPIANT').AsFloat   :=  cdsItens.FieldByName('ITE_IPIENT_ANT').AsFloat;
    qryUpdate.ParamByName('FREANT').AsFloat   :=  cdsItens.FieldByName('ITE_FREENT_ANT').AsFloat;
    qryUpdate.ParamByName('VFRANT').AsFloat   :=  cdsItens.FieldByName('ITE_VALFRE_ANT').AsFloat;
    qryUpdate.ParamByName('CUSANT').AsFloat   :=  cdsItens.FieldByName('ITE_PRECUS_ANT').AsFloat;

    qryUpdate.ParamByName('DF1ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF01_ANT').AsFloat;
    qryUpdate.ParamByName('DF2ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF02_ANT').AsFloat;
    qryUpdate.ParamByName('DF3ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF03_ANT').AsFloat;
    qryUpdate.ParamByName('DF4ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF04_ANT').AsFloat;
    qryUpdate.ParamByName('DF5ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF05_ANT').AsFloat;
    qryUpdate.ParamByName('DF6ANT').AsFloat   :=  cdsItens.FieldByName('ITE_DESF06_ANT').AsFloat;

    qryUpdate.ParamByName('TCIANT').AsFloat   :=  cdsItens.FieldByName('ITE_TCIFCU_ANT').AsFloat;
    qryUpdate.ParamByName('TSCANT').AsFloat   :=  cdsItens.FieldByName('ITE_TSCUST_ANT').AsFloat;
    qryUpdate.ParamByName('DEPANT').AsFloat   :=  cdsItens.FieldByName('ITE_DEPICO_ANT').AsFloat;
    qryUpdate.ParamByName('DEIANT').AsFloat   :=  cdsItens.FieldByName('ITE_DEICMS_ANT').AsFloat;
    qryUpdate.ParamByName('FATANT').AsFloat   :=  cdsItens.FieldByName('ITE_FATREG_ANT').AsFloat;

    qryUpdate.ParamByName('AFNANT').AsFloat   :=  cdsItens.FieldByName('ITE_ACRFIN_ANT').AsFloat;
    qryUpdate.ParamByName('ICEANT').AsFloat   :=  cdsItens.FieldByName('ITE_ICMENT_ANT').AsFloat;
    qryUpdate.ParamByName('SFDANT').AsFloat   :=  cdsItens.FieldByName('ITE_SUBFED_ANT').AsFloat;
    qryUpdate.ParamByName('STIANT').AsFloat   :=  cdsItens.FieldByName('ITE_SUBSTI_ANT').AsFloat;

    qryUpdate.ParamByName('DABANT').AsFloat   := cdsItens.FieldByName('ITE_DESADB_ANT').AsFloat;

    pSetBindCamposCusto(blnResFor, qryUpdate);
    qryUpdate.ParamByName('CODITE').AsString := cdsItens.FieldByName('ITE_CODITE').AsString;
    qryUpdate.ParamByName('CODEMP').AsString := strEmpresas;


    qryUpdate.ExecSQL;
    qryUpdate.Close;

    pAjustaDemaisItens(blnResFor, strEmpresas);

    cdsItens.Next;
  End;

  FreeAndNil(qryUpdate);
End;


procedure TfrmRestauraPreco.btnMarTodClick(Sender: TObject);
begin
  inherited;
  pCriarFormularios(TfrmRestauraPrecoDetalhes, frmRestauraPrecoDetalhes);
  Try
    frmRestauraPrecoDetalhes.Caption := frmRestauraPrecoDetalhes.Caption + ' [Data: ' + cdsDados.FieldByName('ALT_DTAALT').AsString + ' ' +
                                          cdsDados.FieldByName('ALT_HORALT').AsString + ' Operador: ' +
                                          cdsDados.FieldByName('OPERADOR').AsString + ' Qtd: ' +
                                          cdsDados.FieldByName('QTDPRO').AsString + ']';
    pAbreDetalhes;
    frmRestauraPrecoDetalhes.dtsItens.DataSet := cdsItens;
    frmRestauraPrecoDetalhes.ShowModal;
  Finally
    pFreeAndNil(frmRestauraPrecoDetalhes);
  End;

end;

procedure TfrmRestauraPreco.FormCreate(Sender: TObject);
begin
  inherited;
  blnPreMat := fPreMat;
  blnInfMat := fCfgSis('INFMAT', varBoolean);
  intInfFed := fCfgSis('INFFED', varInteger);
  intInfOpe := fCfgSis('INFOPE', varInteger);
  intInfSai := fCfgSis('INFSAI', varInteger);

  cdsItens := TZClient.Create(Self, '');
  cdsDados := TZClient.Create(Self, '');
  cdsDados.qryQuery.SQL.Add('SELECT ALT_DTAALT,');
  cdsDados.qryQuery.SQL.Add('       ALT_HORALT,');
  cdsDados.qryQuery.SQL.Add('       IF(IFNULL(ALT_NOMFRM, "") = "", "Não Identificado", ALT_NOMFRM) AS LOCALT ,');
  cdsDados.qryQuery.SQL.Add('       ALT_CODOPE,');
  cdsDados.qryQuery.SQL.Add('       IF(IFNULL(ALT_CODOPE, "") = "", "Não Identificado", CONCAT(ALT_CODOPE, " - ", OPE_NOMOPE)) AS OPERADOR ,');
  cdsDados.qryQuery.SQL.Add('       COUNT(1) AS QTDPRO,');
  cdsDados.qryQuery.SQL.Add('       ALT_AGRUAP');
  cdsDados.qryQuery.SQL.Add('  FROM PREALT');
  cdsDados.qryQuery.SQL.Add('  LEFT JOIN CADOPE ON OPE_CODOPE = PREALT.ALT_CODOPE');
  cdsDados.qryQuery.SQL.Add(' WHERE ALT_PERRES  = "S"');
  cdsDados.qryQuery.SQL.Add('   AND ALT_CODEMP = "' + VS_StrCodEmp + '"');
  cdsDados.qryQuery.SQL.Add('   AND ALT_DTAALT >= (DATE_SUB(CURDATE(), INTERVAL 10 DAY)) ');
  cdsDados.qryQuery.SQL.Add(' GROUP BY ALT_AGRUAP, ALT_DTAALT, ALT_NOMFRM');
  cdsDados.qryQuery.SQL.Add(' ORDER BY ALT_DTAALT  DESC, ALT_HORALT DESC');

  cdsDados.fAbreClient(True, '[TfrmRestauraPreco.FormCreate]');

  dtsDados.DataSet := cdsDados;
end;

procedure TfrmRestauraPreco.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  case  Key of
    VK_F8: btnMarTod.Click;
    VK_F9: btnRestaura.Click;
  End;
end;

function TfrmRestauraPreco.isTrue(blnCondicional: Boolean): Boolean;
begin
  Result := blnCondicional;
end;

procedure TfrmRestauraPreco.pAbreDetalhes;
begin
  cdsItens.qryQuery.SQL.Clear;
  cdsItens.Close;
  cdsItens.qryQuery.SQL.Add('SELECT ALT_CODEMP AS ITE_CODEMP,');
  cdsItens.qryQuery.SQL.Add('       ALT_CODITE AS ITE_CODITE,');
  cdsItens.qryQuery.SQL.Add('       ALT_CODOPE AS ITE_OPEALT,');
  cdsItens.qryQuery.SQL.Add('       ALT_AGRUAP AS ITE_AGRUAP,');
  cdsItens.qryQuery.SQL.Add('       ALT_NOMFRM AS ITE_LOALTP,');
  cdsItens.qryQuery.SQL.Add('       ALT_DTAALT,');
  cdsItens.qryQuery.SQL.Add('       ALT_HORALT,');
  cdsItens.qryQuery.SQL.Add('       ITE_CODFOR,');
  cdsItens.qryQuery.SQL.Add('       ITE_DESITE,');
  cdsItens.qryQuery.SQL.Add('       IF(IFNULL(ALT_DOLANT, "") = "",  ITE_PREDOL, ALT_DOLANT) AS ITE_PREDOL_ANT,');
  cdsItens.qryQuery.SQL.Add('       IF(IFNULL(ALT_DOLATU, "") = "",  ITE_PREDOL, ALT_DOLATU) AS ITE_PREDOL_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CUSANT AS ITE_PRECUS_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CUSATU AS ITE_PRECUS_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE1ANT AS ITE_PREVE1_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE1ATU AS ITE_PREVE1_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA1ANT AS ITE_MARBR1_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA1ATU AS ITE_MARBR1_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA2ANT AS ITE_MARBR2_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA2ATU AS ITE_MARBR2_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE2ANT AS ITE_PREVE2_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE2ATU AS ITE_PREVE2_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE3ANT AS ITE_PREVE3_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE3ATU AS ITE_PREVE3_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA3ANT AS ITE_MARBR3_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA3ATU AS ITE_MARBR3_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE4ANT AS ITE_PREVE4_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE4ATU AS ITE_PREVE4_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA4ANT AS ITE_MARBR4_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA4ATU AS ITE_MARBR4_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE5ANT AS ITE_PREVE5_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE5ATU AS ITE_PREVE5_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA5ANT AS ITE_MARBR5_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA5ATU AS ITE_MARBR5_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE6ANT AS ITE_PREVE6_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE6ATU AS ITE_PREVE6_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA6ANT AS ITE_MARBR6_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA6ATU AS ITE_MARBR6_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE7ANT AS ITE_PREVE7_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VE7ATU AS ITE_PREVE7_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA7ANT AS ITE_MARBR7_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_MA7ATU AS ITE_MARBR7_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_COMANT AS ITE_PRECOM_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_COMATU AS ITE_PRECOM_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF1ANT AS ITE_DESF01_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF1ATU AS ITE_DESF01_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF2ANT AS ITE_DESF02_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF2ATU AS ITE_DESF02_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF3ANT AS ITE_DESF03_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF3ATU AS ITE_DESF03_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF4ANT AS ITE_DESF04_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF4ATU AS ITE_DESF04_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF5ANT AS ITE_DESF05_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF5ATU AS ITE_DESF05_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF6ANT AS ITE_DESF06_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DF6ATU AS ITE_DESF06_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_SFDANT AS ITE_SUBFED_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_SFDATU AS ITE_SUBFED_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_IPIANT AS ITE_IPIENT_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_IPIATU AS ITE_IPIENT_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_FREANT AS ITE_FREENT_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_FREATU AS ITE_FREENT_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_VFRANT AS ITE_VALFRE_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_VFRATU AS ITE_VALFRE_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_AFNANT AS ITE_ACRFIN_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_AFNATU AS ITE_ACRFIN_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_STIANT AS ITE_SUBSTI_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_STIATU AS ITE_SUBSTI_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DABANT AS ITE_DESADB_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DABATU AS ITE_DESADB_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_OTVANT AS ITE_OUTVAL_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_OTVATU AS ITE_OUTVAL_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_IMSANT AS ITE_ICMSAI_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_IMSATU AS ITE_ICMSAI_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_FEDANT AS ITE_IMPFED_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_FEDATU AS ITE_IMPFED_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DESANT AS ITE_DESOPE_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DESATU AS ITE_DESOPE_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_ICEANT AS ITE_ICMENT_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_ICEATU AS ITE_ICMENT_ATU,');

  cdsItens.qryQuery.SQL.Add('       ALT_TCIANT AS ITE_TCIFCU_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_TCIATU AS ITE_TCIFCU_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_TSCANT AS ITE_TSCUST_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_TSCATU AS ITE_TSCUST_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DEPANT AS ITE_DEPICO_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DEPATU AS ITE_DEPICO_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_DEIANT AS ITE_DEICMS_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_DEIATU AS ITE_DEICMS_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_FATANT AS ITE_FATREG_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_FATATU AS ITE_FATREG_ATU,');

  cdsItens.qryQuery.SQL.Add('       ALT_CM1ANT AS ITE_COMTB1_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM1ATU AS ITE_COMTB1_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM2ANT AS ITE_COMTB2_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM2ATU AS ITE_COMTB2_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM3ANT AS ITE_COMTB3_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM3ATU AS ITE_COMTB3_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM4ANT AS ITE_COMTB4_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM4ATU AS ITE_COMTB4_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM5ANT AS ITE_COMTB5_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM5ATU AS ITE_COMTB5_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM6ANT AS ITE_COMTB6_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM6ATU AS ITE_COMTB6_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM7ANT AS ITE_COMTB7_ANT,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM7ATU AS ITE_COMTB7_ATU,');
  cdsItens.qryQuery.SQL.Add('       ALT_CM7ANT AS ITE_COMTB7_ANT');

  cdsItens.qryQuery.SQL.Add('  FROM PREALT');
  cdsItens.qryQuery.SQL.Add(' INNER JOIN CADITE ON CADITE.ITE_CODITE = ALT_CODITE');
  cdsItens.qryQuery.SQL.Add(' INNER JOIN ITEGER ON ITEGER.ITE_CODITE = ALT_CODITE AND ITEGER.ITE_CODEMP = ALT_CODEMP');

  cdsItens.qryQuery.SQL.Add(' WHERE ALT_PERRES  = "S"');
  cdsItens.qryQuery.SQL.Add('   AND ALT_CODEMP = "' + VS_StrCodEmp + '"');

  If Not fEmptyStr(cdsDados.FieldByName('ALT_AGRUAP').AsString) Then
    cdsItens.qryQuery.SQL.Add('   AND ALT_AGRUAP = :AGRUAP ')
  Else
  begin
    cdsItens.qryQuery.SQL.Add('   AND ALT_AGRUAP IS NULL');
    cdsItens.qryQuery.SQL.Add('   AND ALT_DTAALT = :DTAALT');
  End;

  If Not fEmptyStr(cdsDados.FieldByName('ALT_AGRUAP').AsString) Then
    cdsItens.qryQuery.ParamByName('AGRUAP').Value := cdsDados.FieldByName('ALT_AGRUAP').Value
  Else
    cdsItens.qryQuery.ParamByName('DTAALT').Value := cdsDados.FieldByName('ALT_DTAALT').Value;

  cdsItens.fAbreClient(True, '[TfrmRestauraPreco.pAbreDetalhes]');

End;

procedure TfrmRestauraPreco.pSetBindCamposCusto(blnResFor: Boolean; qryUpdate: TUniQuery);
begin
    If Not blnResFor Then
    Begin

      If IsTrue((Not blnInfMat) Or (intInfFed = 2)) Then
        qryUpdate.ParamByName('FEDANT').AsFloat  :=  cdsItens.FieldByName('ITE_IMPFED_ANT').AsFloat;

      If IsTrue((Not blnInfMat) Or (intInfOpe = 2))  Then
        qryUpdate.ParamByName('DESANT').AsFloat :=  cdsItens.FieldByName('ITE_DESOPE_ANT').AsFloat;

      If IsTrue((Not blnInfMat) Or (intInfSai = 2)) Then
        qryUpdate.ParamByName('IMSANT').AsFloat := cdsItens.FieldByName('ITE_ICMSAI_ANT').AsFloat;

      qryUpdate.ParamByName('OTVANT').AsFloat := cdsItens.FieldByName('ITE_OUTVAL_ANT').AsFloat;
      qryUpdate.ParamByName('MA1ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR1_ANT').AsFloat;
      qryUpdate.ParamByName('MA2ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR2_ANT').AsFloat;
      qryUpdate.ParamByName('MA3ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR3_ANT').AsFloat;
      qryUpdate.ParamByName('MA4ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR4_ANT').AsFloat;
      qryUpdate.ParamByName('MA5ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR5_ANT').AsFloat;
      qryUpdate.ParamByName('MA6ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR6_ANT').AsFloat;
      qryUpdate.ParamByName('MA7ANT').AsFloat := cdsItens.FieldByName('ITE_MARBR7_ANT').AsFloat;
      qryUpdate.ParamByName('CM1ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB1_ANT').AsFloat;
      qryUpdate.ParamByName('CM2ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB2_ANT').AsFloat;
      qryUpdate.ParamByName('CM3ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB3_ANT').AsFloat;
      qryUpdate.ParamByName('CM4ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB4_ANT').AsFloat;
      qryUpdate.ParamByName('CM5ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB5_ANT').AsFloat;
      qryUpdate.ParamByName('CM6ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB6_ANT').AsFloat;
      qryUpdate.ParamByName('CM7ANT').AsFloat := cdsItens.FieldByName('ITE_COMTB7_ANT').AsFloat;
      qryUpdate.ParamByName('VE1ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE1_ANT').AsFloat;
      qryUpdate.ParamByName('VE2ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE2_ANT').AsFloat;
      qryUpdate.ParamByName('VE3ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE3_ANT').AsFloat;
      qryUpdate.ParamByName('VE4ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE4_ANT').AsFloat;
      qryUpdate.ParamByName('VE5ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE5_ANT').AsFloat;
      qryUpdate.ParamByName('VE6ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE6_ANT').AsFloat;
      qryUpdate.ParamByName('VE7ANT').AsFloat := cdsItens.FieldByName('ITE_PREVE7_ANT').AsFloat;
    End;

end;

procedure TfrmRestauraPreco.pSQLCamposCusto(var strUPD: String; blnResFor: Boolean);
begin
  If Not blnResFor Then
  Begin
    strUPD := strUPD + ',  ';

    If (Not blnInfMat) Or (intInfFed = 2) Then
      strUPD := strUPD + 'ITE_IMPFED  =  :FEDANT,';

    If (Not blnInfMat) Or (intInfOpe = 2)  Then
      strUPD := strUPD + 'ITE_DESOPE  =  :DESANT,';

    If (Not blnInfMat) Or (intInfSai = 2)  Then
      strUPD := strUPD + '  ITE_ICMSAI  =  :IMSANT,';

    strUPD := strUPD + '   ITE_OUTVAL = :OTVANT,';
    strUPD := strUPD + '   ITE_MARBR1 = :MA1ANT,';
    strUPD := strUPD + '   ITE_MARBR2 = :MA2ANT,';
    strUPD := strUPD + '   ITE_MARBR3 = :MA3ANT,';
    strUPD := strUPD + '   ITE_MARBR4 = :MA4ANT,';
    strUPD := strUPD + '   ITE_MARBR5 = :MA5ANT,';
    strUPD := strUPD + '   ITE_MARBR6 = :MA6ANT,';
    strUPD := strUPD + '   ITE_MARBR7 = :MA7ANT,';
    strUPD := strUPD + '   ITE_COMTB1 = :CM1ANT,';
    strUPD := strUPD + '   ITE_COMTB2 = :CM2ANT,';
    strUPD := strUPD + '   ITE_COMTB3 = :CM3ANT,';
    strUPD := strUPD + '   ITE_COMTB4 = :CM4ANT,';
    strUPD := strUPD + '   ITE_COMTB5 = :CM5ANT,';
    strUPD := strUPD + '   ITE_COMTB6 = :CM6ANT,';
    strUPD := strUPD + '   ITE_COMTB7 = :CM7ANT,';
    strUPD := strUPD + '   ITE_PREVE1 = :VE1ANT,';
    strUPD := strUPD + '   ITE_PREVE2 = :VE2ANT,';
    strUPD := strUPD + '   ITE_PREVE3 = :VE3ANT,';
    strUPD := strUPD + '   ITE_PREVE4 = :VE4ANT,';
    strUPD := strUPD + '   ITE_PREVE5 = :VE5ANT,';
    strUPD := strUPD + '   ITE_PREVE6 = :VE6ANT,';
    strUPD := strUPD + '   ITE_PREVE7 = :VE7ANT ';
  End;

end;

procedure TfrmRestauraPreco.pAjustaDemaisItens(blnResFor: Boolean; strEmpresas: string);
begin
  If blnInfMat Then
    pRecalculaItensResponsavelFornecedor(strEmpresas, cdsItens.FieldByName('ITE_CODITE').AsString, blnResFor);

  pAtualizaItensGrupoPrecos(cdsItens.FieldByName('ITE_CODITE').AsString, 'RESTAURAÇÃO DE PREÇO - ' + cdsDados.FieldByName('ALT_AGRUAP').AsString, strAgrupadorPreAlt);
End;

End.





