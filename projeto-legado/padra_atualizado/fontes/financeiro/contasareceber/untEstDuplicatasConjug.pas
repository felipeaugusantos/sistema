unit untEstDuplicatasConjug;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, untPai, Grids, DBGridCitel, DBGrids, AppEvnts, Menus, StdCtrls, Buttons,
  ExtCtrls, DB,   Uni, UniDataSetProvider,
  UniClientDataSet, BitBtnLockedIncrem;

type
  TfrmEstDuplicatasConjug = class(TfrmPai)
    dbgGrid: TDBGridCitel;
    dtsGrid: TDataSource;
    qryGrid: TUniQuery;
    cdsGrid: TUniClientDataSet;
    dspGrid: TUniDataSetProvider;
    lblLegenda: TLabel;
    btnConfirma: TBitBtnLocked;
    procedure btnConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dbgGridDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure dbgGridKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    blnConfirma: Boolean;
    strSeqCon: String;
    strEmpRcx: String;
    intResCai: Integer;
  end;

var
  frmEstDuplicatasConjug: TfrmEstDuplicatasConjug;

implementation

uses untModulo, untFuncoes, StrUtils, untFuncoesSimples;

{$R *.dfm}

procedure TfrmEstDuplicatasConjug.btnConfirmaClick(Sender: TObject);
begin
  inherited;
  blnConfirma := True;
  close;
end;

procedure TfrmEstDuplicatasConjug.FormShow(Sender: TObject);
Var
  strSQL: String;
begin
  inherited;

  strSQL := '';

  If intResCai = 0 Then
  Begin
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(CTR_NUMDUP, CTR_PARCEL, "-", CTR_ESPDOC) AS NUMDUP, ';
    strSQL := strSQL + '  CTR_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  CTR_PARCEL AS PARCEL, ';
    strSQL := strSQL + '  CTR_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  CTR_CODEMP AS EMPDUP, ';
    strSQL := strSQL + '  CTR_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  CTR_SEQBAI AS SEQBAI, ';
    strSQL := strSQL + '  CTR_DTACAD AS DTACAD, ';
    strSQL := strSQL + '  CONCAT(CTR_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  CTR_VALREC AS VALDOC, ';
    strSQL := strSQL + '  "D" AS MARDES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADREC ';
    strSQL := strSQL + '  JOIN CADCLI ON (CTR_CODCLI=CLI_CODCLI) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  CTR_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  CTR_CODEMP = :CODEMP ';

    strSQL := strSQL + 'UNION All  ' + AnsiReplaceStr(strSQL, 'CADREC', 'CADRECX');

    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  NUMDUP ';
  End
  Else
  Begin
    strSQL := strSQL + 'SELECT ';
    strSQL := strSQL + '  CONCAT(RCX_NUMDOC, RCX_PARCEL,"-", RCX_ESPDOC) AS NUMDUP, ';
    strSQL := strSQL + '  RCX_NUMDUP AS NRODUP, ';
    strSQL := strSQL + '  RCX_PARCEL AS PARCEL, ';
    strSQL := strSQL + '  RCX_ESPDOC AS ESPDOC, ';
    strSQL := strSQL + '  RCX_EMPDUP AS EMPDUP, ';
    strSQL := strSQL + '  RCX_CODCLI AS CODCLI, ';
    strSQL := strSQL + '  RCX_SEQBAI AS SEQBAI, ';
    strSQL := strSQL + '  RCX_DTACAD AS DTACAD, ';
    strSQL := strSQL + '  CONCAT(RCX_CODCLI, "-", CLI_NOMCLI) AS NOMCLI, ';
    strSQL := strSQL + '  SUM(RCX_VALDOC) AS VALDOC, ';
    strSQL := strSQL + '  "D" AS MARDES ';
    strSQL := strSQL + 'FROM ';
    strSQL := strSQL + '  CADRCXX ';
    strSQL := strSQL + '  JOIN CADCLI ON (RCX_CODCLI=CLI_CODCLI) ';
    strSQL := strSQL + 'WHERE ';
    strSQL := strSQL + '  RCX_SEQCON = :SEQCON AND ';
    strSQL := strSQL + '  RCX_CODEMP = :CODEMP ';
    strSQL := strSQL + 'GROUP BY ';
    strSQL := strSQL + '  RCX_NUMDOC, RCX_PARCEL, RCX_ESPDOC, RCX_CODCLI ';
    strSQL := strSQL + 'ORDER BY ';
    strSQL := strSQL + '  RCX_NUMDOC ';
  End;

  qryGrid.Close;
  qryGrid.SQL.Clear;
  qryGrid.SQL.Add(strSQL);
  qryGrid.ParamByName('SEQCON').AsString := strSeqCon;
  qryGrid.ParamByName('CODEMP').AsString := strEmpRcx;
  qryGrid.Open;

  pSetaClient(qryGrid);

  cdsGrid.SetProvider(dspGrid);
  cdsGrid.Open;
  TFloatField(cdsGrid.FieldByName('VALDOC')).DisplayFormat := '#,##0.00';
  While (Not cdsGrid.Eof) Do
  Begin
    If Not fCtrDuplicataPrincipalBaixada(cdsGrid.FieldByName('NRODUP').AsString,
                                         cdsGrid.FieldByName('PARCEL').AsString,
                                         cdsGrid.FieldByName('ESPDOC').AsString,
                                         cdsGrid.FieldByName('EMPDUP').AsString,
                                         cdsGrid.FieldByName('CODCLI').AsString,
                                         cdsGrid.FieldByName('SEQBAI').AsInteger) Then
    Begin
      cdsGrid.Edit;
      cdsGrid.FieldByName('MARDES').AsString := 'M';
      cdsGrid.Post;
      btnConfirma.Enabled := False;
      lblLegenda.Visible := True;
    End;

    cdsGrid.Next;
  End;

  blnConfirma := False;
end;

procedure TfrmEstDuplicatasConjug.dbgGridDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  inherited;
  If cdsGrid.FieldByName('MARDES').AsString = 'M' Then
  Begin
    dbgGrid.Canvas.Brush.Color := clAqua;
    dbgGrid.Canvas.Font.Color  := clBlack;
  End;

  dbgGrid.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TfrmEstDuplicatasConjug.dbgGridKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
Begin
  inherited;

  Case Key Of
    VK_Return: Self.SelectNext(ActiveControl, True, True);
    VK_Escape: btnSair.Click;
  End;

End;

End.
