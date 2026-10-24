unit untOrdemPageControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ComCtrls, StdCtrls, ExtCtrls, dxGDIPlusClasses;

type
  TOptionOrder = (opLeft, opRight);

Type
   TPageControlOrder = class(TComponent)
     private
       FPageControl: TPageControl;
       FReadOnlyFirstIndex: Boolean;
     public
       procedure pPageOrder(option: TOptionOrder);
       procedure pSavePageOrder(FileName: String);
       procedure pLoadPageOrder(FileName: String);
     published
       property PageControl: TPageControl read FPageControl write FPageControl;
       property ReadOnlyFirstIndex: Boolean read FReadOnlyFirstIndex write FReadOnlyFirstIndex;
   end;

type
  TfrmOrdemPageControl = class(TForm)
    lblInformacao: TLabel;
    imgLeft: TImage;
    imgRight: TImage;
    spbLeft: TSpeedButton;
    spbRight: TSpeedButton;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure spbLeftClick(Sender: TObject);
    procedure spbRightClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    objPageControlOrder: TPageControlOrder;
  end;

var
  frmOrdemPageControl: TfrmOrdemPageControl;

implementation

{$R *.dfm}

{ TPageControlOrder }

procedure TPageControlOrder.pLoadPageOrder(FileName: String);
  var
    stlFile: TStringList;
    intCount: Integer;
    intIndex: Integer;

  function fFindPageByName(pageName: String): TTabSheet;
    var
      intPag: integer;
  begin
    Result := nil;
    For intPag := 0 To FPageControl.PageCount -1 Do
      If FPageControl.Pages[intPag].Name = pageName Then
      Begin
        Result := FPageControl.Pages[intPag];
        Break;
      End;
  end;

begin
  If Not FileExists(FileName) Then
    Exit;

  stlFile := TStringList.Create;
  stlFile.LoadFromFile(FileName);

  intIndex := 0;

  For intCount := 0 To stlFile.Count -1 Do
    If fFindPageByName(stlFile[intCount]) <> nil Then
    begin
      fFindPageByName(stlFile[intCount]).PageIndex := intIndex;
      Inc(intIndex);
    end;

  FreeAndNil(stlFile);
end;

procedure TPageControlOrder.pPageOrder(option: TOptionOrder);
  var
    intNewIndex: Integer;
    intIndex: Integer;
begin
  intIndex := FPageControl.ActivePageIndex;
  intNewIndex := FPageControl.ActivePageIndex;

  If FReadOnlyFirstIndex Then
  Begin
    If (intIndex = 0) Or
       ((option = opLeft) And (Pred(intIndex) = 0)) Then
    Begin
      Exit;
    End;
  End;

  Case option Of
    opLeft : Dec(intNewIndex);
    opRight: Inc(intNewIndex);
  end;

  If intNewIndex In [0..Pred(FPageControl.PageCount)] Then
  Begin
    FPageControl.ActivePage.PageIndex := intNewIndex;
    FPageControl.SelectNextPage(True);
    FPageControl.ActivePageIndex      := intNewIndex;
  End;
end;

procedure TPageControlOrder.pSavePageOrder(FileName: String);
  var
    stlFile: TStringList;
    intIndex: Integer;
begin
  stlFile := TStringList.Create;

  For intIndex := 0 To FPageControl.PageCount -1 Do
    stlFile.Add(FPageControl.Pages[intIndex].Name);

  stlFile.SaveToFile(FileName);
  FreeAndNil(stlFile);
end;

procedure TfrmOrdemPageControl.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  Case Key Of
    VK_LEFT   : spbLeftClick(nil);
    VK_RIGHT  : spbRightClick(nil);
    VK_ESCAPE : Close;
  end;
end;

procedure TfrmOrdemPageControl.spbLeftClick(Sender: TObject);
begin
  objPageControlOrder.pPageOrder(opLeft);
end;

procedure TfrmOrdemPageControl.spbRightClick(Sender: TObject);
begin
  objPageControlOrder.pPageOrder(opRight);
end;

end.
