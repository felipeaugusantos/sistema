unit untCadBoxEti;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, untZClient;

type
  TfrmCadBoxEti = class(TForm)
    frxCadBoxEti: TfrxReport;
    frxdbCadBoxEti: TfrxDBDataset;
  private
    { Private declarations }
  public
    { Public declarations }
    cdsCadBox : TZClient;
    function fRetSQl : String;
    procedure pImprimirBoxSep(strNumdoc, strEspDoc, strCodemp, strCodCli: String; strFilaImp : String = '');
  end;

implementation

{$R *.dfm}
 uses
  untFuncoesSimples;
{ TfrmCadBoxEti }

function TfrmCadBoxEti.fRetSQl: String;
begin
  Result := ' SELECT FGO_NUMDOC AS NUMDOC                                    ';
  Result := Result + '    ,FGO_ESPDOC AS ESPDOC                              ';
  Result := Result + '    ,FGO_CODEMP AS CODEMP                              ';
  Result := Result + '    ,FGO_SEQSEP AS SEQSEP                              ';
  Result := Result + '    ,CLI_CODCLI AS CODCLI                              ';
  Result := Result + '    ,CLI_NOMCLI AS NOMCLI                              ';
  Result := Result + '    ,BOX_CODIGO AS CODBOX                              ';
  Result := Result + '  FROM FATGOR                                          ';
  Result := Result + '  INNER JOIN EXTGOR ON FGO_SEQFGO = FATGOR.AUTOINCREM  ';
  Result := Result + '  INNER JOIN CADCLI ON FGO_CODCLI = CLI_CODCLI         ';
  Result := Result + '  LEFT JOIN CADBOX ON BOX_NUMDOC = FGO_NUMDOC          ';
  Result := Result + '                  AND BOX_ESPDOC = FGO_ESPDOC          ';
  Result := Result + '                  AND BOX_EMPDOC = FGO_CODEMP          ';
  Result := Result + '  WHERE FGO_NUMDOC = :NUMDOC                           ';
  Result := Result + '    AND FGO_ESPDOC = :ESPDOC                           ';
  Result := Result + '    AND FGO_CODEMP = :CODEMP                           ';
  Result := Result + '    AND FGO_CODCLI = :CODCLI                           ';
end;

procedure TfrmCadBoxEti.pImprimirBoxSep(strNumdoc, strEspDoc, strCodemp, strCodCli: String; strFilaImp : String = '');
begin
  cdsCadBox := TZClient.Create(nil, fRetSQl);

  cdsCadBox.qryQuery.Close;
  cdsCadBox.qryQuery.ParamByName('NUMDOC').AsString := strNumdoc;
  cdsCadBox.qryQuery.ParamByName('ESPDOC').AsString := strEspDoc;
  cdsCadBox.qryQuery.ParamByName('CODEMP').AsString := strCodemp;
  cdsCadBox.qryQuery.ParamByName('CODCLI').AsString := strCodCli;

  cdsCadBox.fAbreClient(True, 'pImprimirBoxSep');

  Try
    frxdbCadBoxEti.DataSet := cdsCadBox;
    frxCadBoxEti.PrepareReport();

    If Not fEmptyStr(strFilaImp) Then
    Begin
      frxCadBoxEti.PrintOptions.Printer := strFilaImp;
      frxCadBoxEti.PrintOptions.ShowDialog := False;
      frxCadBoxEti.Print;
    End
    Else
      frxCadBoxEti.ShowPreparedReport;
  Finally
    FreeAndNil(cdsCadBox);
  End;
end;

end.
