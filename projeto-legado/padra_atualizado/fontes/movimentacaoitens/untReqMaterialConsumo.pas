unit untReqMaterialConsumo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, StdCtrls, ExtCtrls, DB, DBClient, Provider,
  AppEvnts, Menus, EditFocus, Mask, MaskEditFocus, Grids, DBGrids, Buttons,
  frxExportTXT, frxExportRTF, frxExportXLS, frxExportHTML, frxExportPDF,
  frxDMPExport, frxDBSet, BitBtnLockedIncrem, frxDMPClass, Math,
  UniClientDataSet, UniDataSetProvider, MemDS, DBAccess, Uni, untTypesSistema,
  frxExportCSVTestabilidade, DBGridCitel, frxClass, frxDesgn;

type
  TfrmReqMaterialConsumo = class(TfrmPaiOrdena)
    btnExcluir: TBitBtnLocked;
    btnDigManual: TBitBtnLocked;
    btnAlterar: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnDigManualClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure edtStringEnter(Sender: TObject);
  private
    { Private declarations }

    Function fExcluiMovReq(strAutInc: String): Boolean;
    Procedure pImprimeRequisicao;

  public
    intStatus : Integer;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
  end;


implementation

{$R *.dfm}

Uses
   CheckLst,  untReqMCoDigManual, untCfgRel, untFuncoesSimples, untMovGer,
  untFatImpressao;

function TfrmReqMaterialConsumo.fGetSql(blnLike: Boolean): String;
Var
  strSQL: String;
Begin
  strSQL := '';
  strSQL := strSQL + ' /* untReqMaterialConsumo */';
  strSQL := strSQL + ' SELECT       ';
  strSQL := strSQL + '   G.AUTOINCREM,         ';
  strSQL := strSQL + '   REQ_NUMREQ AS NUMREQ, ';
  strSQL := strSQL + '   G.REQ_CODEMP AS CODEMP, ';
  strSQL := strSQL + '   REQ_DTAENT AS DTAENT, ';
  strSQL := strSQL + '   REQ_CODDIG AS CODDIG, ';
  strSQL := strSQL + '   REQ_CODENT AS CODENT, ';
  strSQL := strSQL + '   G.REQ_TIP_FC AS TIP_FC, ';
  strSQL := strSQL + '   G.REQ_FORCLI AS FORCLI, ';
  strSQL := strSQL + '   IF(REQ_TIP_FC = "C", C.CLI_NOMCLI, F.FOR_NOMFOR) AS NOM_FC, ';
  strSQL := strSQL + '   REQ_MEN001 AS MEN001, ';
  strSQL := strSQL + '   REQ_MEN002 AS MEN002, ';
  strSQL := strSQL + '   IF(REQ_BAIXAD="S","ENCERRADA", "ABERTA") AS BAIXAD, ';
  strSQL := strSQL + '   REQ_BAIXAD, ';

  strSQL := strSQL + '   CONCAT(CLI_ENDERE, " ", IFNULL(CLI_ENDNUM, "")) AS CLI_ENDERE, ';
  strSQL := strSQL + '   CLI_CODCID AS CLI_CODCID, ';
  strSQL := strSQL + '   CLI_CGCCPF AS CLI_CGCCPF, ';
  strSQL := strSQL + '   CLI_BAIRRO AS CLI_BAIRRO, ';
  strSQL := strSQL + '   CLI_C_E_P_ AS CLI_C_E_P_, ';
  strSQL := strSQL + '   IFNULL(CLI_I_E_S_, CLI_NUMR_G) AS CLI_IESREG, ';
  strSQL := strSQL + '   CLI_FONE01 AS CLI_FONE01, ';

  strSQL := strSQL + '   CONCAT(FOR_ENDERE, " ", IFNULL(FOR_ENDNUM, "")) AS FOR_ENDERE, ';
  strSQL := strSQL + '   FOR_CODCID AS FOR_CODCID, ';
  strSQL := strSQL + '   FOR_CGCCPF AS FOR_CGCCPF, ';
  strSQL := strSQL + '   FOR_BAIRRO AS FOR_BAIRRO, ';
  strSQL := strSQL + '   FOR_C_E_P_ AS FOR_C_E_P_, ';
  strSQL := strSQL + '   IFNULL(FOR_I_E_S_, FOR_NUMRG_) AS FOR_IESREG, ';
  strSQL := strSQL + '   FOR_FONE01 AS FOR_FONE01, ';

  strSQL := strSQL + '   (SELECT SUM(REQ_TOTMCO) FROM MOVRQD D WHERE D.REQ_SEQGER = G.AUTOINCREM AND D.REQ_CODEMP = G.REQ_CODEMP) AS VALTOT ';
  strSQL := strSQL + ' FROM                    ';
  strSQL := strSQL + '   MOVRQG G              ';
  strSql := strSql + '  LEFT JOIN CADCLI C ON C.CLI_CODCLI = G.REQ_FORCLI  ';
  strSql := strSql + '  LEFT JOIN CADFOR F ON F.FOR_CODFOR = G.REQ_FORCLI  ';
  strSQL := strSQL + ' WHERE                   ';
  strSQL := strSQL + '   REQ_CODEMP = ' + QuotedStr(VS_strCodEmp);

  Case intStatus Of
    1 : strSQL := strSQL + ' AND REQ_BAIXAD = "N" ';
    2 : strSQL := strSQL + ' AND REQ_BAIXAD = "S" ';
  End;

  Result := strSQL;
End;

procedure TfrmReqMaterialConsumo.FormShow(Sender: TObject);
  Const
    FATOR_IMP_MAT = 4.497913762;
begin
  inherited;
  blnSempreRelerBanco := FALSE;
  blnTemSelecao := FALSE;

  lflLastField.intIndCol := 0;
  lflLastField.strNomCam := dbgConsulta.Columns[0].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[0].Title.Caption;
  lflLastField.ftyTipCam := ftString;

  fAbreConsulta(TRUE);

end;

procedure TfrmReqMaterialConsumo.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F8    : btnDigManual.Click;
    VK_DELETE: btnExcluir.Click;
    VK_RETURN: If (pnlPesquisa.Focused) Then
                 SelectNext(ActiveControl, True, True)
               Else
                 btnAlterar.Click;
    VK_ESCAPE: btnSair.Click;              
  End;

end;

Function TfrmReqMaterialConsumo.fExcluiMovReq(strAutInc: String): Boolean;
  Var
    qryGenReq: TUniQuery;
Begin
  Try
    qryGenReq := fCriaQuery;
    With qryGenReq, SQL Do
    Begin
      Clear;
      Add('DELETE FROM MOVRQG WHERE AUTOINCREM = :AUTINC');
      ParamByName('AUTINC').AsString := strAutInc;
      ExecSQL;
    End;
    Result := TRUE;

  Except
    On E: Exception Do
    Begin
      Result := FALSE;
      pMensagensErro(E.Message, '[fExcluiMovReq]');
    End;
  End;

End;

procedure TfrmReqMaterialConsumo.btnAlterarClick(Sender: TObject);
  Var
    objMCODig: TMCOReqMaterial;
begin
  inherited;

  If cdsConsulta.FieldByName('REQ_BAIXAD').AsString = 'S' Then
  Begin
    fMensagem('', 'Não é possível alterar uma solicitação já atendida!', ['&Ok']);
    Exit;
  End;

  If Not btnAlterar.Visible Then
    Exit;

  With cdsConsulta Do
  Begin
    If IsEmpty Then
      Exit;

    objMCODig := TMCOReqMaterial.Create(Self);
    If objMCODig.fAlteraRequisicao(FieldByName('NUMREQ').AsString,
                             FieldByName('TIP_FC').AsString,
                             FieldByName('FORCLI').AsString) Then
    Begin
      fAbreConsulta(TRUE);
      Locate('AUTOINCREM', objMCODig.strAutInc, []);
      pImprimeRequisicao;
    End;

    FreeAndNil(objMCODig);

  End;


end;

procedure TfrmReqMaterialConsumo.btnDigManualClick(Sender: TObject);
  Var
    objMCODig: TMCOReqMaterial;
begin
  inherited;

  If Not btnDigManual.Visible Then
    Exit;

  objMCODig := TMCOReqMaterial.Create(Self);

  If objMCODig.fAlteraRequisicao Then
  Begin
    fAbreConsulta(TRUE);
    cdsConsulta.Locate('AUTOINCREM', objMCODig.strAutInc, []);
    pImprimeRequisicao;
  End;

  FreeAndNil(objMCODig);

end;

procedure TfrmReqMaterialConsumo.btnExcluirClick(Sender: TObject);
begin
  inherited;

  With cdsConsulta Do
  Begin
    If Not Active Then
      Exit;

    If IsEmpty Then
      Exit;

    If fMensagem('','Confirma a exclusão da Requisição ' + cdsConsulta.fieldByName('NUMREQ').AsString + ' ?', ['&Sim', '&Não'] ) = 1 Then
    Begin

      Try
        If fExcluiMovReq(FieldByName('AUTOINCREM').AsString) Then
          Delete;
      Except
        On E: Exception Do
        Begin
          pMensagensErro(E.Message, '[btnExcluir]');
        End;
      End;
    End;
  End;

end;

procedure TfrmReqMaterialConsumo.edtStringEnter(Sender: TObject);
begin
  inherited;
  If lflLastField.strNomCam = 'NUMREQ' Then
  Begin
    edtString.TamCampo := 12;
    edtString.CompZeros := True;
  End
  Else
  Begin
    edtString.TamCampo := 0;
    edtString.CompZeros := False;
  End;

end;

procedure TfrmReqMaterialConsumo.pImprimeRequisicao;
  Var
    strNomeArquivo : String;
Begin
  If fMensagem('', 'Imprimir?', ['&Sim', '&Não']) = 1 Then
  Begin
    pImprimeFatImp('MOVRQG',
                   cdsConsulta.FieldByName('NUMREQ').AsString,
                   'RQ',
                   VS_strCodEmp,
                   cdsConsulta.FieldByName('FORCLI').AsString,
                   'F',
                   '',
                   False,
                   strNomeArquivo,
                   False,
                   'I',
                   1,
                   impSemPrecoGeral);
  End;
End;

end.
