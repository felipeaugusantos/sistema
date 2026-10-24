unit untConsultaPedCom;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPaiOrdena, DB, UniClientDataSet, UniDataSetProvider, 
   Uni, AppEvnts, Menus, StdCtrls, EditFocus, Mask,
  MaskEditFocus, Grids, DBGridCitel, DBGrids, Buttons, ExtCtrls,
  BitBtnLockedIncrem, MemDS, DBAccess, Datasnap.Provider;

type
  TfrmConsultaPedCom = class(TfrmPaiOrdena)
    btnTransf: TBitBtnLocked;
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strNumPed: String;
    strCodEmp: String;
    strOpcDoc: String;
    blnCancel: Boolean;
  protected
    function fGetSql(blnLike: Boolean): String; Override;
  end;

var
  frmConsultaPedCom: TfrmConsultaPedCom;

implementation

uses untFuncoesSimples;

{$R *.dfm}

procedure TfrmConsultaPedCom.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;

  Case Key Of
    VK_F10 : Begin
               btnTransf.Click;
               Key := 0;
             End;
  End;

end;

procedure TfrmConsultaPedCom.FormCreate(Sender: TObject);
begin
  inherited;

  strNumPed := '';
end;

procedure TfrmConsultaPedCom.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;

  If (ModalResult = mrOk) And (Not cdsConsulta.IsEmpty) Then
    strNumPed := cdsConsulta.FieldByName('PCG_NUMPED').AsString;

end;

function TfrmConsultaPedCom.fGetSql(blnLike: Boolean): String;

  function fGetSqlTab(blnDelet: Boolean): String;
    Var
      strSql: String;
  Begin

    strSQL := '';
    strSQL := strSQL + 'SELECT ';

    If blnDelet Then
      strSQL := strSQL + '  "S" AS CANCEL, '
    Else
      strSQL := strSQL + '  "N" AS CANCEL, ';

    strSQL := strSQL + '  PCG_NUMPED, ';
    strSQL := strSQL + '  PCG_CODEMP, ';
    strSQL := strSQL + '  PCG_ESPDOC, ';
    strSQL := strSQL + '  PCG_CODFOR, ';
    strSQL := strSQL + '  FOR_NOMFOR AS PCG_NOMFOR, ';
    strSQL := strSQL + '  PCG_DTAPED, ';
    strSQL := strSQL + '  PCG_DTAENT, ';
    strSQL := strSQL + '  PCG_CONPAG, ';
    strSQL := strSQL + '  PCG_TOTITE, ';
    strSQL := strSQL + '  PCG_TOTIPI, ';
    strSQL := strSQL + '  PCG_TOTSUB, ';
    strSQL := strSQL + '  PCG_VALFRE, ';
    strSQL := strSQL + '  PCG_TOTGER, ';
    strSQL := strSQL + '  P.AUTOINCREM, ';
    strSQL := strSQL + '  PCG_EMPDES  ';
    strSQL := strSQL + 'FROM ';

    If blnDelet Then
      strSQL := strSQL + '  DEL_PCMGER P, '
    Else
      strSQL := strSQL + '  PCMGER P, ';

    strSQL := strSQL + '  CADFOR  ';
    strSQL := strSQL + 'WHERE ';

    strSQL    := strSQL + '  PCG_ESPDOC = ' + QuotedStr(strOpcDoc);

    strSQL := strSQL + '  AND PCG_NUMCTN = 0 ';
    strSQL := strSQL + '  AND FOR_CODFOR = PCG_CODFOR ';

    If Not fEmptyStr(strCodEmp) Then
      strSQL := strSQL + '  AND PCG_CODEMP  = ' + QuotedStr(strCodEmp) + ' ';

    Result := strSQL;
  End;

Begin
  Result := fGetSqlTab(False);

  If blnCancel Then
  Begin
   Result := Result + fFiltraSQL(blnlike) + ' UNION ALL ' + fGetSqlTab(True);
  End;
End;

procedure TfrmConsultaPedCom.FormShow(Sender: TObject);
begin
  inherited;

  blnTemSelecao := False;

  dbgConsulta.Columns[0].Visible := blnCancel;

  lflLastField.intIndCol := 6;
  lflLastField.strNomCam := dbgConsulta.Columns[6].FieldName;
  lflLastField.strNomCol := dbgConsulta.Columns[6].Title.Caption;
  lflLastField.ftyTipCam := ftDateTime;

  fAbreConsulta(True);

end;

end.
