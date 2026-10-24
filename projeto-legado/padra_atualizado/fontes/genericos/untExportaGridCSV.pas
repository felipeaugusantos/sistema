unit untExportaGridCSV;

interface

uses
  SysUtils, Windows, Classes, Menus, Uni, DB, StrUtils, Forms,
  CxProgressBar, cxGridDBBandedTableView,cxGridDBDataDefinitions ,
  untGravando, cxGridBandedTableView;

Type
  TOnGetContentFieldExportGridCSV = procedure(strField: String; var strConteudo: String) of Object;
  TExportaGridCSV = class(TComponent)
    Private

      frmGravando: TfrmGravando;

      FNomeArquivo: String;

      FView: TcxGridDBBandedTableView;

      FOnGetContentFieldExportGridCSV: TOnGetContentFieldExportGridCSV;

      Function fExportaPrg(cxProgresso: TcxProgressBar): Boolean;

      Function fPedeArquivo: Boolean;
      procedure pEscreveLinha(strField: string; Linha: TStringList; strConteudo: String);
      function  fGetColumByPosition(PosBand: Integer; Position: Integer): TcxGridBandedColumn;


    public
      Property OnGetContentFieldExportGridCSV:TOnGetContentFieldExportGridCSV read FOnGetContentFieldExportGridCSV write FOnGetContentFieldExportGridCSV;
      constructor Create(Owner: TComponent; cxView: TcxGridDBBandedTableView); Reintroduce;
      Destructor Destroy; override;

      Function fExporta: Boolean;

  End;

implementation

Uses
  System.Variants,
  Vcl.Dialogs,
  untFuncoesSimples;

constructor TExportaGridCSV.Create(Owner: TComponent; cxView: TcxGridDBBandedTableView);
Begin
  Inherited Create(Owner);

  FView := cxView;
End;

Destructor TExportaGridCSV.Destroy;
Begin
  Inherited;

End;

Function TExportaGridCSV.fExporta: Boolean;
Begin
  Result := fPedeArquivo And
            TfrmGravando.fExecuta(fExportaPrg, frmGravando, 'Gerando arquivo, aguarde...');
End;

Function TExportaGridCSV.fPedeArquivo: Boolean;
  Var
    savPedeArquivo: TSaveDialog;
Begin
  Result := False;
  FNomeArquivo := '';

  savPedeArquivo := TSaveDialog.Create(Self);
  savPedeArquivo.Filter     := 'Arquivos CSV|*.csv';
  savPedeArquivo.DefaultExt := 'csv';

  If savPedeArquivo.Execute Then
  Begin
    Result := True;
    FNomeArquivo := savPedeArquivo.FileName;
  End;

  FreeAndNil(savPedeArquivo);
End;


procedure TExportaGridCSV.pEscreveLinha(strField: string; Linha: TStringList; strConteudo: String);
begin
  If Assigned(FOnGetContentFieldExportGridCSV) Then
    FOnGetContentFieldExportGridCSV(strField, strConteudo);
  Linha.Add(strConteudo);

end;

Function TExportaGridCSV.fGetColumByPosition(PosBand: Integer; Position: Integer): TcxGridBandedColumn;
  var
    intContador: integer;
begin
  Result := nil;
  For intContador := 0 To FView.Bands[PosBand].ColumnCount - 1 Do
  Begin
    If FView.Bands[PosBand].Columns[intContador].Position.ColIndex = Position Then
    Begin
      Result := FView.Bands[PosBand].Columns[intContador];
      break;
    End;
  End;
End;

Function TExportaGridCSV.fExportaPrg(cxProgresso: TcxProgressBar): Boolean;
  Var
    intValues,
    intBands: Integer;
    intContador: Integer;
    stlIndex,
    stlLinha,
    stlField,
    stlLinhas: TStringList;
    Column: TcxGridBandedColumn;
Begin
  Try
    cxProgresso.Properties.Max := FView.ViewData.RecordCount;

    stlLinhas := TStringList.Create;
    stlLinha  := TStringList.Create;
    stlIndex  := TStringList.Create;
    stlField  := TStringList.Create;

    For intBands := 0 To FView.Bands.Count - 1 Do
    begin

      If FView.Bands[intBands].Visible Then
        For intContador := 0 To FView.Bands[intBands].ColumnCount - 1 Do
        Begin
          Column := fGetColumByPosition(intBands, intContador);
          If Column.Visible Then
          Begin
            If Column.AlternateCaption.IsEmpty Then
              stlLinha.Add(Column.Caption)
            Else
              stlLinha.Add(Column.AlternateCaption);

            stlIndex.Add(Column.Index.ToString());
            stlField.Add(TcxGridItemDBDataBinding(Column.DataBinding).FieldName);
          End;
        End;
    end;

    stlLinhas.Add(fCommaText(stlLinha, False, ';'));
    stlLinha.Clear;

    For intContador := 0 To FView.ViewData.RecordCount - 1 Do
    Begin

      If FView.ViewData.Records[intContador].IsData Then
      Begin

        For intValues := 0 To stlIndex.Count - 1 Do
          pEscreveLinha(stlField[intValues], stlLinha, VarToStr(FView.ViewData.Records[intContador].Values[stlIndex[intValues].ToInteger]));
        stlLinhas.Add(fCommaText(stlLinha, False, ';'));
        stlLinha.Clear;
      End;

      cxProgresso.Position := cxProgresso.Position + 1;
      Application.ProcessMessages;
    End;

    frmGravando.lblGravando.Caption := 'Salvando arquivo, aguarde...';
    Application.ProcessMessages;

    stlLinhas.SaveToFile(FNomeArquivo);

    pMensagemOk('Arquivo gerado com sucesso!');

    Result := True;
  Except

    On E: Exception Do
    Begin
      Result := False;
      pMensagensErro(E.Message, 'TCSV.fExportaDados');
    End;

  End;

  FreeAndNil(stlIndex);
  FreeAndNil(stlLinha);
  FreeAndNil(stlLinhas);
End;


end.
