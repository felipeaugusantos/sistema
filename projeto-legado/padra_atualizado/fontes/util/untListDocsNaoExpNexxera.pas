unit untListDocsNaoExpNexxera;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
  Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls, StrUtils,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider, Datasnap.DBClient,
  frxClass, frxExportCSVTestabilidade;

type
  TfrmListDocsNaoExpNexxera = class(TfrmPaiOrdena)
    lblCodEmp: TLabel;
    edtCodEmp: TEditFocus;
    edtNomEmp: TEditFocus;
    lbl1: TLabel;
    edtCodFor: TEditFocus;
    edtNomFor: TEditFocus;
    mskDtaIni: TMaskEditFocus;
    mskDtaFin: TMaskEditFocus;
    lblDtaIni: TLabel;
    lbl2: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  protected
    function fGetSql(blnLike: Boolean): String; Override;
    function fAbreConsulta(blnLike: Boolean): Boolean; Override;
  public
    { Public declarations }
    strDocSel: String;
    strAutoIn: String;
  end;

var
  frmListDocsNaoExpNexxera: TfrmListDocsNaoExpNexxera;

implementation

uses
    untFuncoesSimples;

{$R *.dfm}

function TfrmListDocsNaoExpNexxera.fAbreConsulta(
  blnLike: Boolean): Boolean;
begin
  Result := inherited fAbreConsulta(blnLike);
end;

function TfrmListDocsNaoExpNexxera.fGetSql(blnLike: Boolean): String;
  Var
    strSQL: String;
begin
  strSQL := '';
  strSQL := strSQL + 'SELECT SQL_NO_CACHE ';
  strSQL := strSQL + '   G.GER_NUMDOC,    ';
  strSQL := strSQL + '   G.GER_ESPDOC,    ';
  strSQL := strSQL + '   G.GER_CODEMP,    ';
  strSQL := strSQL + '   G.GER_CODCLI,    ';
  strSQL := strSQL + '   C.CLI_NOMCLI,    ';
  strSQL := strSQL + '   G.GER_VLRCON,    ';
  strSQL := strSQL + '   G.AUTOINCREM     ';
  strSQL := strSQL + 'FROM                ';
  strSQL := strSQL + '   MOVGER G         ';
  strSQL := strSQL + '   INNER JOIN CADCLI C ON C.CLI_CODCLI = G.GER_CODCLI ';
  strSQL := strSQL + '   INNER JOIN MOVDET D ON D.DET_SEQGER = G.AUTOINCREM ';
  strSQL := strSQL + '   INNER JOIN CADITE I ON I.ITE_CODITE = D.DET_CODITE ';
  strSQL := strSQL + 'WHERE       ';
  strSQL := strSQL + '   G.GER_DTAENT BETWEEN "' + FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaIni.Text)) + '" AND "' +
                                                   FormatDateTime('yyyy-mm-dd', StrToDate(mskDtaFin.Text)) + '" ';
  If Not fEmptyStr(edtCodEmp.Text) Then
    strSQL := strSQL + '   AND D.DET_CODEMP = "' + edtCodEmp.Text + '" '
  Else
    strSQL := strSQL + '   AND LOCATE(D.DET_CODEMP, ' + QuotedStr(strEmpAcessoUsuarioLogado) + ') > 0 ';
  If Not fEmptyStr(edtCodFor.Text) Then
    strSQL := strSQL + '   AND I.ITE_CODFOR = "' + edtCodFor.Text + '" ';

  strSQL := strSQL + '   AND D.DET_PROEMB <> "S"    ';
  strSQL := strSQL + '   AND D.DET_TIP_FC = "C"     ';
  strSQL := strSQL + '   AND C.CLI_CGCCPF = "1"     ';
  strSQL := strSQL + '   AND G.GER_CODCLI NOT IN (' + VS_strCliFil + ') ';
  strSQL := strSQL + '   AND D.DET_ESPDOC NOT IN ("FF", "TR", "DV")     ';
  strSQL := strSQL + '   AND ((LOCATE(D.DET_CLAFIS, "' + VS_strClaVen + '") > 0) OR (LOCATE(D.DET_CLAFIS, "' + VS_strClaDev + '") > 0)) ';
  strSQL := strSQL + 'GROUP BY         ';
  strSQL := strSQL + '   G.GER_NUMDOC, ';
  strSQL := strSQL + '   G.GER_ESPDOC, ';
  strSQL := strSQL + '   G.GER_CODEMP, ';
  strSQL := strSQL + '   G.GER_CODCLI  ';
  Result := strSQL;
end;

procedure TfrmListDocsNaoExpNexxera.FormShow(Sender: TObject);
begin
  inherited;
  fAbreConsulta(True);
end;

procedure TfrmListDocsNaoExpNexxera.btnConfirmaClick(Sender: TObject);
  Var
    intIndex: Integer;
begin
  inherited;
  With cdsConsulta Do
  Begin
    If (stlListSelecao.Count = 1) Then
    Begin
      If Locate('AUTOINCREM', Copy(stlListSelecao[0], 2, 20), []) Then
      Begin
        strAutoIn := Copy(stlListSelecao[0], 2, 20);
        strDocSel := FieldByName('GER_NUMDOC').AsString + '-' +
                     FieldByName('GER_ESPDOC').AsString + ';'
      End
      Else
      Begin
        fMensagem('','Registro não Localizado!', ['&OK']);
        Exit;
      End;
    End
    Else
    Begin
      For intIndex := 0 To stlListSelecao.Count - 1 Do
      Begin
        If Locate('AUTOINCREM', Copy(stlListSelecao[intIndex], 2, 20),[]) Then
        Begin
          strAutoIn := strAutoIn + Copy(stlListSelecao[intIndex], 2, 20) + '_';
          strDocSel := strDocSel + FieldByName('GER_NUMDOC').AsString + '-' +
                                   FieldByName('GER_ESPDOC').AsString + ';';
        End
        Else
        Begin
          fMensagem('','Registro não Localizado!', ['&OK']);
          Break;
        End;
      End;
    End;
  End;
  ModalResult := mrOk;
end;

procedure TfrmListDocsNaoExpNexxera.FormKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  Case Key Of
    VK_ESCAPE: if (ActiveControl = dbgConsulta) Then
                 pSetFocus(btnSair)
               Else
                 inherited;
    VK_F10   : btnConfirma.Click;
    Else       inherited;
  End;
end;

end.
