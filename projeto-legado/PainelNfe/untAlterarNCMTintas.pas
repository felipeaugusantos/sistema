unit untAlterarNCMTintas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB,

  {$IF Defined(UNIDAC)}
    Uni
  {$ELSE}
    ZConnection, ZDataset
  {$IFEND}
  ;

type
  TfrmAlterarNCMTintas = class(TForm)
    dbgItens: TDBGrid;
    Panel1: TPanel;
    dtsItens: TDataSource;
    procedure dbgItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    procedure pInformarNovoNCM;
    procedure pAtualizarNCM(strNCM: String);
    { Private declarations }
  public
    { Public declarations }
    strTabela: String;
  end;

var
  frmAlterarNCMTintas: TfrmAlterarNCMTintas;

implementation

uses untUtil, untModulo{$IF Defined(VER250) Or Defined(VER270) Or Defined(VER280) Or Defined(VER300)}, System.UITypes{$IFEND};

{$R *.dfm}

procedure TfrmAlterarNCMTintas.dbgItensKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  If Key = VK_ESCAPE Then
    Close
  Else If Key = VK_RETURN Then
    pInformarNovoNCM;
end;

procedure TfrmAlterarNCMTintas.pInformarNovoNCM;
  Var
    strNCM: String;
begin
  strNCM := dbgItens.DataSource.DataSet.FieldByName('TRI_NCMTIN').AsString;
  
  If InputQuery('Informe o novo NCM', 'Informe o novo NCM', strNCM) Then
  Begin
    If fEmptyStr(strNCM) Then
    Begin
      If MessageDlg('Confirma o novo NCM em branco?', mtWarning, [mbYes, mbNo], 0) <> mrYes Then
      Begin
        Exit;
      End;
    End;

    If Length(strNCM) > 10 Then
    Begin
      MessageDlg('O código NCM pode ter no máximo 10 digitos.', mtInformation, [mbOk], 0);
      Exit;
    End;

    If StrToFloatDef(strNCM, -1) = -1 Then
    Begin
      MessageDlg('O código NCM deve conter apenas números.', mtInformation, [mbOk], 0);
      Exit;
    End;

    pAtualizarNCM(strNCM);
  End;
end;

procedure TfrmAlterarNCMTintas.pAtualizarNCM(strNCM: String);
  Var
    qryUpd: {$IF Defined(UNIDAC)} TUniQuery {$ELSE} TZQuery {$IFEND};
begin
  qryUpd := fCriaQuery(Self);
  qryUpd.SQL.Add('UPDATE ');
  qryUpd.SQL.Add('  ' + strTabela + ' ');
  qryUpd.SQL.Add('SET ');
  qryUpd.SQL.Add('  TRI_NCMTIN = :NCMTIN ');
  qryUpd.SQL.Add('WHERE ');
  qryUpd.SQL.Add('  DET_SEQGER = :SEQGER ');

  qryUpd.ParamByName('NCMTIN').AsString := strNCM;
  qryUpd.ParamByName('SEQGER').AsString := dbgItens.DataSource.DataSet.FieldByName('AUTOINCREM').AsString;
  qryUpd.ExecSQL;

  FreeAndNil(qryUpd);

  dbgItens.DataSource.DataSet.Close;
  dbgItens.DataSource.DataSet.Open;
end;

end.
