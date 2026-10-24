{************************************************************************}
{* "Ha quem se faca rico, nao tendo coisa alguma; e quem se faca pobre, *}
{*  tendo grande riqueza."                                              *}
{*                         (Proverbios Cap.13:7)                        *}
{*********************************************************************JC*}

unit untGeraDbf;

interface

uses Classes, Variants, DB, Dbf, SysUtils;

type
  TGeraDbf = Class(TObject)
  private
    FTabela: TDbf;
    FOrigem: TDataSet;

  protected

  public
    constructor Create;
    destructor Destroy;

    function CriarArquivo(strPath, strNome: String): Boolean;

  published

    property Dados_Origem: TDataSet read FOrigem write FOrigem;

  end;

  ExceptionGeraDbf = Class(Exception);

implementation

constructor TGeraDbf.Create;
begin
  inherited Create;
  FTabela := TDbf.Create(Nil);
end;

destructor TGeraDbf.Destroy;
begin
  FreeAndNil(FTabela);
  inherited Destroy;
end;

function TGeraDbf.CriarArquivo(strPath, strNome: String): Boolean;
  Var
    intCont: Integer;
begin

  If Assigned(FOrigem) Then
  Begin

    FTabela.FieldDefs.Clear;

    For intCont := 0 To FOrigem.Fields.Count -1 Do
    Begin
      With FTabela.FieldDefs.AddFieldDef Do
      Begin
        Name     := FOrigem.Fields[intCont].FieldName;
        DataType := FOrigem.Fields[intCont].DataType;
        Size     := FOrigem.Fields[intCont].Size;
      End;
    End;

    If FileExists(strPath + '\' + strNome) Then
      DeleteFile(strPath + '\' + strNome);

    FTabela.FilePath  := strPath;
    FTabela.TableName := strNome;
    FTabela.CreateTable;
    FTabela.Open;
    FTabela.EmptyTable;

    With FOrigem Do
    Begin
      First;
      While Not Eof Do
      Begin
        FTabela.Append;
        For intCont := 0 To Fields.Count -1 Do
          FTabela.Fields[intCont].Value := Fields[intCont].Value;
        FTabela.Post;
        Next;
      End;

    End;

    FTabela.Close;
    Result := True;

  End
  Else
    Raise ExceptionGeraDbf.Create('Para gerar o arquivo é necessário informar os dados de origem!');

end;

end.
